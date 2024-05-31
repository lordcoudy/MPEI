#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include "CL/cl.hpp"
#include "opencv2/opencv.hpp"

#ifdef _WIN32
#include <windows.h>
#else
#include <stdlib.h>
#include <sys/time.h>
long long GetTickCount64()
{
    struct timeval ts;
    gettimeofday(&ts, NULL);
    return ts.tv_sec * 1000 + ts.tv_usec / 1000;
}
#endif

/* 1) Получить сведения о всех платформах OpenCL и всех устройствах OpenCL,
доступных в Вашей системе;
2) Переписать программу, разработанную в л.р. 5, используя язык OpenCL С и
OpenCL API;
3) Для каждого доступного устройства OpenCL измерить времена выполнения
обработки изображений разрешения FullHD (1920x1080). Подобрать такое
количество рабочих групп и элементов, чтобы время обработки было
минимальным. Измерить время обработки с учётом передачи данных между
хостом и устройством, а также время выполнения ядра;
4) Вычислить коэффициент ускорения выполнения программы на GPU
относительно CPU (программы, разработанной в л.р.4), а также долю времени,
которую занимает обмен данными при решении задачи на GPU. Результаты
измерений привести в таблице;
5) Сравнить времена выполнения задачи на OpenCL и CUDA.  */

template<typename Func>
double measureExecutionTime(Func func);
void calculateKernel(float* kernel, int sigma);
std::vector<cv::Mat> readImages(const std::vector<std::string>& paths);
void runGaussRowCPU(const unsigned char* srcImage, unsigned char* dstImage, int width, int height, const float* filter, int kernel_radius);
void runGaussColCPU(const unsigned char* srcImage, unsigned char* dstImage, int width, int height, const float* filter, int kernel_radius);
void runCPU(const cv::Mat& src, const float* kernel, cv::Mat& dst, int kernel_radius);
int runOpenCL(const cv::Mat& src, const float* kernel, cv::Mat& dst, int kernel_radius);

constexpr int radSigCoeff = 3;
constexpr double PI = 3.141592653;

int main() {
    std::vector<int> sigmas = { 1, 2, 3, 4, 5 };
    std::vector<int> radii = { sigmas[0] * radSigCoeff, sigmas[1] * radSigCoeff, sigmas[2] * radSigCoeff, sigmas[3] * radSigCoeff, sigmas[4] * radSigCoeff };
    std::vector<float*> kernels;

    for (int i = 0; i < sigmas.size(); i++) {
        auto k = new float[radii[i] * 2 + 1];
        calculateKernel(k, sigmas[i]);
        kernels.push_back(k);
    }

    std::vector<std::string> paths = {
            "image1.tiff",
            "image2.tiff",
            "image3.tiff",
    };

    std::ofstream globalTime("../gpu.csv", std::ios::app);
    globalTime << "radius" << "," << "width" << "," << "height" << "," << "time(ms)" << "," << "mem1(ms)" << ","
               << "mem2(ms)" << "\n";
    globalTime.close();

    std::ofstream cpuTime("../cpu.csv", std::ios::app);
    cpuTime << "radius" << "," << "width" << "," << "height" << "," << "time(ms)" << "\n";
    cpuTime.close();

    for (const auto & path : paths) {
        auto time = 0.0;
        cv::Mat srcImage = imread("../" + path, cv::IMREAD_GRAYSCALE);
        if (srcImage.empty()) {
            std::cerr << "Could not open or find the image" << std::endl;
            return -1;
        }
        cv::Mat dstImage = srcImage.clone();
        cv::Mat dstImageCPU = srcImage.clone();
        for (int j = 0; j < sigmas.size(); j++) {
            auto kernel = kernels[j];
            time = measureExecutionTime([&]() {
                runCPU(srcImage, kernel, dstImageCPU, radii[j]);
            });
            std::ofstream cpuTime("../cpu.csv", std::ios::app);
            std::cout << "\nProcessing time for CPU (ms): " << time << "\n";
            cpuTime << radii[j] << "," << srcImage.cols << "," << srcImage.rows << "," << time << "\n";
            cpuTime.close();
            auto output_cpu = "../cpu_" + std::to_string(radii[j]) + "_" + path;
            cv::imwrite(output_cpu, dstImageCPU);

            if (runOpenCL(srcImage, kernel, dstImage, radii[j]) != 0) {
                return -1;
            };
            auto output_gpu = "../gpu_" + std::to_string(radii[j]) + "_" + path;
            imwrite(output_gpu, dstImage);
        }

    }

    return 0;
}

template<typename Func>
double measureExecutionTime(Func func)
{
    auto startTime = std::chrono::high_resolution_clock::now();
    func();
    auto endTime = std::chrono::high_resolution_clock::now();
    auto duration = std::chrono::duration_cast<std::chrono::nanoseconds>(endTime - startTime).count();
    return duration / 1e6;
}

void calculateKernel(float* kernel, int sigma)
{
    int radius = radSigCoeff * sigma;
    for (int i = 0; i <= radius; i++) {
        kernel[i + radius] = kernel[radius - i] = exp(
                -(pow(i, 2) / (2 * pow(sigma, 2)))
        ) / (
                                                          sqrt(2 * PI * pow(sigma, 2))
                                                  );
    }
}

void runCPU(const cv::Mat& src, const float* kernel, cv::Mat& dst, int kernel_radius)
{
    cv::Mat tmp(src);
    runGaussRowCPU(src.ptr(0), tmp.ptr(0), src.cols, src.rows, kernel, kernel_radius);
    runGaussColCPU(tmp.ptr(0), dst.ptr(0), tmp.cols, tmp.rows, kernel, kernel_radius);
}

void runGaussRowCPU(const unsigned char* srcImage, unsigned char* dstImage, int width, int height, const float* filter, int kernel_radius)
{
    for (int y = 0; y < height; y++)
        for (int x = 0; x < width; x++) {
            float sum = 0;
            for (int k = -kernel_radius; k <= kernel_radius; k++) {
                int d = x + k;
                if (d >= 0 && d < width)
                    sum += srcImage[y * width + d] * filter[kernel_radius - k];
            }
            dstImage[y * width + x] = sum;
        }
}

void runGaussColCPU(const unsigned char* srcImage, unsigned char* dstImage, int width, int height, const float* filter, int kernel_radius)
{
    for (int y = 0; y < height; y++)
        for (int x = 0; x < width; x++) {
            float sum = 0;
            for (int k = -kernel_radius; k <= kernel_radius; k++) {
                int d = y + k;
                if (d >= 0 && d < height)
                    sum += srcImage[d * width + x] * filter[kernel_radius - k];
            }
            dstImage[y * width + x] = sum;
        }
}

const std::string openCLSource = R"(
    __kernel void gaussRow(__global unsigned char* srcImage, __global unsigned char* dstImage, int width, int height, __global float* filter, int kernel_radius)
    {
        int col = get_global_id(0) / width;
        int row = get_global_id(0) % height;
        float sum = 0;
        if (row < height && col < width)
        {
            for (int k = -kernel_radius; k <= kernel_radius; k++) {
                int curCol = col + k;
                if ((row * width + curCol) >= 0 && (row * width + curCol) < (width * height))
                    sum += srcImage[row * width + curCol] * filter[kernel_radius + k];
            }
            dstImage[row * width + col] = sum;
        }
    }
    __kernel void gaussCol(__global unsigned char* srcImage, __global unsigned char* dstImage, int width, int height, __global float* filter, int kernel_radius)
    {
        int col = get_global_id(0) / width;
        int row = get_global_id(0) % height;
        float sum = 0;
        if (row < height && col < width)
        {
            for (int k = -kernel_radius; k <= kernel_radius; k++) {
                int curRow = row + k;
                if ((col * height + curRow) >= 0 && (col * height + curRow) < (width * height))
                    sum += srcImage[col * height + curRow] * filter[kernel_radius + k];
            }
            dstImage[col * height + row] = sum;
        }
    }
)";

int runOpenCL(const cv::Mat& src, const float* kernel, cv::Mat& dst, int kernel_radius)
{
    auto width = src.cols;
    auto height = src.rows;
    auto image_size = width * height;

    const int workGroupSize = 32;
    const int workGroupsCount = ceil(float(width * height) / (workGroupSize * workGroupSize));
    const int platformIndex = 0;
    cl_uint deviceCount = 0;
#pragma region Example
    cl_uint platformCount; // количетсво платформ в системе
    if (clGetPlatformIDs(0, nullptr, &platformCount) != CL_SUCCESS) { // получение значения количества платформ в системе
        std::cerr << "Cannot get platforms!" << std::endl;
        return 1;
    }
    if (platformCount == 0) {
        std::cerr << "No platforms found!" << std::endl;
        return 1;
    }
    std::vector<cl_platform_id> platforms(platformCount); // массив объектов платформ
    if (clGetPlatformIDs(platformCount, platforms.data(), nullptr) != CL_SUCCESS) { // заполнение массива platform объектами типа "платформа"
        std::cerr << "Cannot get platforms!" << std::endl;
        return 1;
    }
    std::cout << "Found " << platforms.size() << " platforms" << std::endl;
    if (platformIndex >= platforms.size()) {
        std::cerr << "Invalid platform index" << std::endl;
        return 1;
    }
    const cl_platform_id platformId = platforms[platformIndex];
    // получение информации об устройствах GPU для заданной платформы
    if (clGetDeviceIDs(platformId, CL_DEVICE_TYPE_GPU, 0, nullptr, &deviceCount) != CL_SUCCESS) {
        std::cerr << "Cannot get devices!" << std::endl;
        return 1;
    }
    if (deviceCount == 0) {
        std::cerr << "No devices found!" << std::endl;
        return 1;
    }
    std::vector<cl_device_id> devices(deviceCount);
    if (clGetDeviceIDs(platformId, CL_DEVICE_TYPE_GPU, deviceCount, devices.data(), nullptr) != CL_SUCCESS) {
        std::cerr << "Cannot get devices!" << std::endl;
        return 1;
    }
    std::cout << "Found " << devices.size() << " devices" << std::endl;

    // создание контекста
    cl_int ret = 0; // переменная для хранения кода ошибки
    cl_context context = clCreateContext(nullptr, 1, devices.data(), nullptr, nullptr, &ret); // создаём контекст для всех GPU-устройств платформы
    if (ret != 0) {
        std::cerr << "Cannot create context!" << std::endl;
        return 1;
    }

    const auto startAll = GetTickCount64();

    // создание объекта - программы
    const char* sourcePtr = openCLSource.data();
    size_t sourceSize = openCLSource.size();
    cl_program program = clCreateProgramWithSource(context, 1, &sourcePtr, &sourceSize, &ret); // создание объекта - программы
    if (clBuildProgram(program, 1, devices.data(), nullptr, nullptr, nullptr) != CL_SUCCESS) {
        // вывод отчёта об ошибках компиляции
        std::cerr << "clBuildProgram for deivce id=" << devices[0] << " failed, error: " << ret << std::endl;
        size_t buildLogLen = 0;
        if (clGetProgramBuildInfo(program, devices[0], CL_PROGRAM_BUILD_LOG, 0, nullptr, &buildLogLen) == CL_SUCCESS) {
            std::vector<char> buildLog(buildLogLen);
            if (clGetProgramBuildInfo(program, devices[0], CL_PROGRAM_BUILD_LOG, buildLogLen, buildLog.data(), nullptr) == CL_SUCCESS) {
                std::cerr << "Build log" << std::endl;
                std::cerr << "-------------------------------------------" << std::endl;
                std::cerr << buildLog.data() << std::endl;
                std::cerr << "-------------------------------------------" << std::endl;
            }
        }
        clReleaseContext(context); // освобождение контекста
        return 1;
    }

    // создание объекта очереди команд для заданного контекста и устройства (платформы, вида устройств)
    // функция clCreateCommandQueue объявлена устаревшей, начиная с OpenCL 2.0, использовать эту функцию для версий OpenCL, предшествующих 2.0
    // cl_command_queue commandQueue = clCreateCommandQueue(context, devices[0], CL_QUEUE_PROFILING_ENABLE, &ret);
    const std::vector<cl_queue_properties> props = { CL_QUEUE_PROPERTIES, CL_QUEUE_PROFILING_ENABLE, 0 }; // включение этой опции необходимо для измерения времени выполнения операций
    // если изменение времени не нужно, вместо props.data() можно передать NULL
    cl_command_queue commandQueue = clCreateCommandQueueWithProperties(context, devices[0], props.data(), &ret);

    if (ret != 0) {
        std::cerr << "Cannot create command queue!" << std::endl;
        clReleaseProgram(program); // удаление объекта - программы
        clReleaseContext(context); // удаление контекста
        return 1;
    }
#pragma endregion
    // создание объекта функции-ядра
    cl_kernel kernelRow = clCreateKernel(program, "gaussRow", &ret);
    if (ret != 0) {
        std::cerr << "Cannot create kernel!" << std::endl;
        clReleaseCommandQueue(commandQueue); // удаление очереди команд
        clReleaseProgram(program); // удаление объекта - программы
        clReleaseContext(context); // удаление контекста
        return 1;
    }

    cl_kernel kernelCol = clCreateKernel(program, "gaussCol", &ret);
    if (ret != 0) {
        std::cerr << "Cannot create kernel!" << std::endl;
        clReleaseCommandQueue(commandQueue); // удаление очереди команд
        clReleaseProgram(program); // удаление объекта - программы
        clReleaseContext(context); // удаление контекста
        return 1;
    }

    // выделение буферов на устройстве под исходные данные и результат
    cl_mem buf_src = clCreateBuffer(context, CL_MEM_READ_WRITE, image_size * sizeof(cl_uchar), nullptr, &ret);
    cl_mem buf_tmp = clCreateBuffer(context, CL_MEM_READ_WRITE, image_size * sizeof(cl_uchar), nullptr, &ret);
    cl_mem buf_dst = clCreateBuffer(context, CL_MEM_READ_WRITE, image_size * sizeof(cl_uchar), nullptr, &ret);
    cl_mem buf_kernel = clCreateBuffer(context, CL_MEM_READ_WRITE, (2 * kernel_radius + 1) * sizeof(float), nullptr, &ret);

    // события, в данном случае они нужно только для замеров времени
    cl_event startMemEvent; // событие, с которым связана операция копирования (начало копирования входных данных)
    cl_event startMemEvent2; // событие, с которым связана операция копирования (начало копирования входных данных)
    cl_event kernelRowEvent; // событие, соответствующее выполнению ядра gaussRow
    cl_event kernelColEvent; // событие, соответствующее выполнению ядра gaussCol
    cl_event endMemEvent; // событие, с которым связана операция копирования результата

    // постановка в очередь операций копирования
    clEnqueueWriteBuffer(commandQueue, buf_src, CL_TRUE, 0, image_size * sizeof(cl_uchar), src.ptr(0), 0, nullptr, &startMemEvent);
    clWaitForEvents(1, &startMemEvent);
    clEnqueueWriteBuffer(commandQueue, buf_kernel, CL_TRUE, 0, (2 * kernel_radius + 1) * sizeof(float), kernel, 0, nullptr, &startMemEvent2);
    clWaitForEvents(1, &startMemEvent2);
    // установка аргументов ядра
    clSetKernelArg(kernelRow, 0, sizeof(cl_mem), &buf_src);
    clSetKernelArg(kernelRow, 1, sizeof(cl_mem), &buf_tmp);
    clSetKernelArg(kernelRow, 2, sizeof(int), &width);
    clSetKernelArg(kernelRow, 3, sizeof(int), &height);
    clSetKernelArg(kernelRow, 4, sizeof(cl_mem), &buf_kernel);
    clSetKernelArg(kernelRow, 5, sizeof(int), &kernel_radius);

    // установка аргументов ядра
    clSetKernelArg(kernelCol, 0, sizeof(cl_mem), &buf_tmp);
    clSetKernelArg(kernelCol, 1, sizeof(cl_mem), &buf_dst);
    clSetKernelArg(kernelCol, 2, sizeof(int), &width);
    clSetKernelArg(kernelCol, 3, sizeof(int), &height);
    clSetKernelArg(kernelCol, 4, sizeof(cl_mem), &buf_kernel);
    clSetKernelArg(kernelCol, 5, sizeof(int), &kernel_radius);

    // запуск ядра
    cl_uint workDim = 1; // размерность пространства-множества исполняющих устройств
    size_t globalWorkSize = workGroupSize * workGroupsCount;
    size_t localWorkSize = workGroupSize;

    // постановка ядра в очередь
    clEnqueueNDRangeKernel(commandQueue, kernelRow, workDim, nullptr, &globalWorkSize, &localWorkSize, 0, nullptr, &kernelRowEvent);
    clWaitForEvents(1, &kernelRowEvent);
    // постановка ядра в очередь
    clEnqueueNDRangeKernel(commandQueue, kernelCol, workDim, nullptr, &globalWorkSize, &localWorkSize, 0, nullptr, &kernelColEvent);
    clWaitForEvents(1, &kernelColEvent);

    // постановка в очередь операции копирования результатов на хост
    clEnqueueReadBuffer(commandQueue, buf_dst, CL_TRUE, 0, image_size * sizeof(cl_uchar), dst.ptr(0), 0, nullptr, &endMemEvent);
    clWaitForEvents(1, &endMemEvent);

    // ожидание завершения выполнения всех операций в командной очереди
    clFinish(commandQueue);

    const auto endAll = GetTickCount64();
    std::cout << "Processing time, including compilation: " << endAll - startAll << " ms" << std::endl;

    // измерение времён работы
    cl_ulong enqueueTime;
    clGetEventProfilingInfo(startMemEvent, CL_PROFILING_COMMAND_QUEUED, sizeof(cl_ulong), &enqueueTime, nullptr); // время постановки в очередь команды на запись
    cl_ulong transferStartTime;
    clGetEventProfilingInfo(startMemEvent, CL_PROFILING_COMMAND_START, sizeof(cl_ulong), &transferStartTime, nullptr); // время начала передачи исходных данных
    cl_ulong kernelRowStartTime;
    clGetEventProfilingInfo(kernelRowEvent, CL_PROFILING_COMMAND_START, sizeof(cl_ulong), &kernelRowStartTime, nullptr); // время начала выполнения ядра
    cl_ulong kernelRowEndTime;
    clGetEventProfilingInfo(kernelRowEvent, CL_PROFILING_COMMAND_END, sizeof(cl_ulong), &kernelRowEndTime, nullptr); // время окончания выполнения ядра
    cl_ulong kernelColStartTime;
    clGetEventProfilingInfo(kernelColEvent, CL_PROFILING_COMMAND_START, sizeof(cl_ulong), &kernelColStartTime, nullptr); // время начала выполнения ядра
    cl_ulong kernelColEndTime;
    clGetEventProfilingInfo(kernelColEvent, CL_PROFILING_COMMAND_END, sizeof(cl_ulong), &kernelColEndTime, nullptr); // время окончания выполнения ядра
    cl_ulong transferEndTime;
    clGetEventProfilingInfo(endMemEvent, CL_PROFILING_COMMAND_END, sizeof(cl_ulong), &transferEndTime, nullptr); // время начала передачи исходных данных

    std::cout << "Time in queue: " << transferStartTime - enqueueTime << " ns" << std::endl; // счётчики в наносекундах
    std::cout << "Processing time: " << transferEndTime - transferStartTime << " ns " << std::endl;
    std::cout << "Kernel execution time: " << kernelRowEndTime - kernelRowStartTime << " ns " << std::endl;

    std::ofstream globalTime("../gpu.csv", std::ios::app);                  // Открытие файла
    // Вывод в файл
    globalTime << kernel_radius << "," << width << "," << height << "," << transferEndTime - transferStartTime << ","
               << kernelRowEndTime - kernelRowStartTime << "," << kernelColEndTime - kernelColStartTime << "\n";
    globalTime.close();

    // после завершения clFinish можно использовать res - массив, в который сохранены данные

    // удаление объектов-событий
    clReleaseEvent(endMemEvent);
    clReleaseEvent(kernelRowEvent);
    clReleaseEvent(startMemEvent);

    // освобождение буферов на устройстве
    clReleaseMemObject(buf_src);
    clReleaseMemObject(buf_tmp);
    clReleaseMemObject(buf_dst);
    clReleaseMemObject(buf_kernel);

    clReleaseKernel(kernelRow); // удаление объекта функции-ядра
    clReleaseKernel(kernelCol); // удаление объекта функции-ядра
    clReleaseCommandQueue(commandQueue); // удаление очереди команд
    clReleaseProgram(program); // удаление объекта - программы
    clReleaseContext(context); // удаление контекста

    return 0;
}