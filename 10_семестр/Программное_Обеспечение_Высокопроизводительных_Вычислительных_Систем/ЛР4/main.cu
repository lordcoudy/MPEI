// ВНИМАНИЕ
// ЛОВУШКА
// В КОДЕ ДОПУЩЕНЫ ОШИБКИ, ВЛИЯЮЩИЕ НА РАБОТУ АЛГОРИТМА
// КТО ПОЧИНИТ - ТОТ МОЛОДЕЦ

#include <iostream>
#include <fstream>
#include <vector>
#include <opencv2/opencv.hpp>
#include <cooperative_groups.h>

namespace cg = cooperative_groups;

using namespace std;
using namespace cv;
using namespace std::chrono;

#define PI 3.141592653
#define radSigCoeff 3
#define BLOCK_SIZE 32

// Запрограммировать алгоритм Гауссова размытия. Этот фильтр используется для подавления шума.

#define checkCUDA(expression) { gpuAssert((expression), __FILE__, __LINE__); }
inline void gpuAssert(cudaError_t status, const char* file, int line)
{
    if (status != cudaSuccess)
    {
        std::cerr << "GPUassert: " << cudaGetErrorString(status) << ", " << file << ", " << line << std::endl;
        std::exit(EXIT_FAILURE);
    }
}

// Функция для расчёта времени выполнения функции
template<typename Func>
double measureExecutionTime(Func func) {
    auto startTime = high_resolution_clock::now();
    func();
    auto endTime = high_resolution_clock::now();
    auto duration = duration_cast<nanoseconds>(endTime - startTime).count();
    return duration / 1e6;                      // Перевод в миллисекунды
}

void calculateKernel(float *kernel, int sigma) {
    int radius = radSigCoeff * sigma;
    for (int i = 0; i <= radius; i++) {
        kernel[i + radius] = kernel[radius - i] = exp(
                -(pow(i, 2) / (2 * pow(sigma,2)))
                ) / (
                        sqrt(2 * PI * pow(sigma, 2))
                        );
    }
}

__global__ void gaussianBlurRowsGPU(
        const unsigned char *srcImage, unsigned char *dstImage, int width, int height,
        const float *kernel, int kernel_radius) {
    int col = blockIdx.x * blockDim.x + threadIdx.x;
    int row = blockIdx.y * blockDim.y + threadIdx.y;

    if ((row >= 0) && (col >= 0) && (row < height) && (col < width))
    {
        float sum = 0.0f;
        float coeffSum = 0.0f;
        float coeff = 0.0f;
        for (int i = -kernel_radius; i <= kernel_radius; i++) {
            coeff = kernel[i + kernel_radius];
            int currentCol = col + i;
            if ((row * width + currentCol) >= 0 && (row * width + currentCol) < (width * height)) {
                sum += srcImage[row * width + currentCol] * coeff;
                coeffSum += coeff;
            }
        }
        dstImage[row * width + col] = sum / (coeffSum > 0 ? coeffSum : 1);
    }
}

__global__ void gaussianBlurColsGPU(
        const unsigned char *srcImage, unsigned char *dstImage, int width, int height,
        const float *kernel, int kernel_radius) {
    int col = blockIdx.x * blockDim.x + threadIdx.x;
    int row = blockIdx.y * blockDim.y + threadIdx.y;

    if ((row >= 0) && (col >= 0) && (row < height) && (col < width))
    {
        float sum = 0.0f;
        float coeffSum = 0.0f;
        float coeff = 0.0f;
        for (int i = -kernel_radius; i <= kernel_radius; i++) {
            coeff = kernel[i + kernel_radius];
            int currentRow = row + i;
            if ((col * height + currentRow) >= 0 && (col * height + currentRow) < (width * height)) {
                sum += srcImage[col * height + currentRow] * coeff;
                coeffSum += coeff;
            }
        }
        dstImage[col * height + row] = sum / (coeffSum > 0 ? coeffSum : 1);
    }
}

void runCuda(Mat &srcImage, Mat &dstImage, float *kernel, int &kernel_radius) {
    // Use cuda event to catch time
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);

    /*Get image size*/
    int height = srcImage.rows;										// number of input image rows
    int width = srcImage.cols;										// number of input image columns

    const long long imageSize = height * width;
    unsigned char* d_input = nullptr, * d_output = nullptr, * d_tmp = nullptr;
    float* d_kernel = nullptr;

    Mat tmpImage = srcImage.clone();
    // Allocate device memory
    checkCUDA(cudaMalloc(&d_input, imageSize * sizeof(unsigned char)));
    checkCUDA(cudaMalloc(&d_tmp, imageSize * sizeof(unsigned char)));
    checkCUDA(cudaMalloc(&d_output, imageSize * sizeof(unsigned char)));
    checkCUDA(cudaMalloc(&d_kernel, (kernel_radius * 2 + 1) * sizeof(float)));


    // Copy data from OpenCV input image to device memory
    checkCUDA(cudaMemcpy(d_input, srcImage.ptr(), imageSize * sizeof(unsigned char), cudaMemcpyHostToDevice));
    checkCUDA(cudaMemcpy(d_kernel, kernel, (kernel_radius * 2 + 1) * sizeof(float), cudaMemcpyHostToDevice));

    // Specify block size
    dim3 block(BLOCK_SIZE, BLOCK_SIZE);
    dim3 grid((int)ceil((float)width / block.x), (int)ceil((float)srcImage.rows / block.y));

    // Start time
    cudaEventRecord(start);

    // Launch kernel
    gaussianBlurRowsGPU<<<grid, block>>>(d_input, d_tmp, width, height, d_kernel, kernel_radius);
    gaussianBlurColsGPU<<<grid, block>>>(d_tmp, d_output, width, height, d_kernel, kernel_radius);
    checkCUDA(cudaPeekAtLastError());

    // End time
    cudaEventRecord(stop);

    //Copy data from device memory to output image
    checkCUDA(cudaMemcpy(dstImage.ptr(), d_output, imageSize * sizeof(unsigned char), cudaMemcpyDeviceToHost));

    //Free the device memoryS
    cudaFree(d_input);
    cudaFree(d_tmp);
    cudaFree(d_output);
    cudaFree(d_kernel);
    cudaEventSynchronize(stop);

    float time;                                                     // Время
    cudaEventElapsedTime(&time, start, stop);                       // Расчёт времени
    ofstream globalTime("../gpu.csv", std::ios::app);                  // Открытие файла
    cout << "\nProcessing time for shared memory GPU (ms): " << time << "\n";     // Вывод в поток
    // Вывод в файл
    globalTime << kernel_radius << "," << width << "," << height << "," << time << "\n";
    globalTime.close();                                                // Закрытие файла
}

void gaussianBlurRowsCPU(unsigned char *srcImage, unsigned char *dstImage, int width, int height,
                         float *kernel, int kernel_radius)
{
    for (int y = 0; y < height; y++)
        for (int x = 0; x < width; x++) {
            float sum = 0;
            for (int k = -kernel_radius; k <= kernel_radius; k++) {
                int d = x + k;
                if (d >= 0 && d < width)
                    sum += srcImage[y * width + d] * kernel[kernel_radius - k];
            }
            dstImage[y * width + x] = sum;
        }
}

void gaussianBlurColsCPU(unsigned char *srcImage, unsigned char *dstImage, int width, int height,
                         float *kernel, int kernel_radius)
{
    for (int y = 0; y < height; y++)
        for (int x = 0; x < width; x++) {
            float sum = 0;
            for (int k = -kernel_radius; k <= kernel_radius; k++) {
                int d = y + k;
                if (d >= 0 && d < height)
                    sum += srcImage[d * width + x] * kernel[kernel_radius - k];
            }
            dstImage[y * width + x] = sum;
        }
}

void runCpu(Mat &srcImage, Mat &dstImage, float *kernel, int &kernel_radius) {
    Mat tmpImage = srcImage.clone();
    gaussianBlurRowsCPU(srcImage.ptr(), tmpImage.ptr(), srcImage.cols, srcImage.rows, kernel, kernel_radius);
    gaussianBlurColsCPU(tmpImage.ptr(), dstImage.ptr(), srcImage.cols, srcImage.rows, kernel, kernel_radius);
}

int main() {
    vector<int> sigmas = {1, 2, 3, 4, 5};
    vector<int> radii = {sigmas[0]*radSigCoeff, sigmas[1]*radSigCoeff, sigmas[2]*radSigCoeff, sigmas[3]*radSigCoeff, sigmas[4]*radSigCoeff};
    vector<float*> kernels;

    for (int i = 0; i < sigmas.size(); i++) {
        auto *kernel = new float[radii[i]*2 + 1];
        calculateKernel(kernel, sigmas[i]);
        kernels.push_back(kernel);
    }

    vector<string> paths = {
            "image1.tiff",
            "image2.tiff",
            "image3.tiff",
    };
    
    for (const auto & path : paths)
    {
        Mat srcImage = imread("../"+path, IMREAD_GRAYSCALE);
        if (srcImage.empty()) {
            cerr << "Could not open or find the image" << endl;
            return -1;
        }

        Mat dstImage = srcImage.clone();
        Mat dstImageCPU = srcImage.clone();

        ofstream globalTime("../gpu.csv", std::ios::app);
        globalTime << "radius" << "," << "width" << "," << "height" << "," << "time(ms)" << "\n";
        globalTime.close();

        ofstream cpuTime("../cpu.csv", std::ios::app);
        cpuTime << "radius" << "," << "width" << "," << "height" << "," << "time(ms)" << "\n";
        cpuTime.close();

        double time = 0;
        for (int i = 0; i < kernels.size(); i++) {
            time = measureExecutionTime([&](){ runCpu(srcImage, dstImageCPU, kernels[i], radii[i]); });
            ofstream cpuTime("../cpu.csv", std::ios::app);
            cout << "\nProcessing time for CPU (ms): " << time << "\n";
            cpuTime << radii[i] << "," << srcImage.cols << "," << srcImage.rows << "," << time << "\n";
            cpuTime.close();
            string output_cpu = "../cpu_" + to_string(radii[i]) + "_" + path;
            imwrite(output_cpu, dstImageCPU);

            runCuda(srcImage, dstImage, kernels[i], radii[i]);
            string output_gpu = "../gpu_" + to_string(radii[i]) + "_" + path;
            imwrite(output_gpu, dstImage);
        }
    }


    for (auto & kernel : kernels) {
        delete[] kernel;
    }

    return 0;
}
