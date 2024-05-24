#pragma region Libs
#include <iostream>
#include <vector>
#include <fstream>
#include <chrono>
#include <cuda_runtime.h>
using namespace std;
using namespace std::chrono;
#pragma endregion

// Значение степени по умолчанию
const int m = 3;

#pragma region CUDA checking
// Макрос и процедура для проверки выполнения CUDA кода
#define gpuErrchk(ans) { gpuAssert((ans), __FILE__, __LINE__); }
inline void gpuAssert(cudaError_t code, const char* file, int line, bool abort = true)
{
    if (code != cudaSuccess)
    {
        fprintf(stderr, "GPUassert: %s %s %d\n", cudaGetErrorString(code), file, line);
        if (abort) exit(code);
    }
}
#pragma endregion

#pragma region CPU time count
// Функция для расчёта времени выполнения функции
template<typename Func>
double measureExecutionTime(Func func) {
    auto startTime = high_resolution_clock::now();
    func();
    auto endTime = high_resolution_clock::now();
    auto duration = duration_cast<nanoseconds>(endTime - startTime).count();
    return duration / 1e6;                      // Перевод в миллисекунды
}
#pragma endregion

#pragma region Info
// Вся информация о CUDA и GPU
void AboutDevice()
{
    printf("\n-------------------------- BEGIN OF DEVICE INFO --------------------------\n");
    printf("Starting...\n\n");

    int deviceCount = 0;
    cudaError_t error_id = cudaGetDeviceCount(&deviceCount);

    if (error_id != cudaSuccess) {
        printf("cudaGetDeviceCount returned %d\n-> %s\n",
               static_cast<int>(error_id), cudaGetErrorString(error_id));
        printf("Result = FAIL\n");
        exit(EXIT_FAILURE);
    }

    // This function call returns 0 if there are no CUDA capable devices.
    if (deviceCount == 0) {
        printf("There are no available device(s) that support CUDA\n");
    }
    else {
        printf("Detected %d CUDA Capable device(s)\n", deviceCount);
    }

    int dev = 0, driverVersion = 0, runtimeVersion = 0;

    cudaSetDevice(dev);
    cudaDeviceProp deviceProp{};
    cudaGetDeviceProperties(&deviceProp, dev);

    printf("\nDevice %d: \"%s\"\n", dev, deviceProp.name);

    // Console log
    cudaDriverGetVersion(&driverVersion);
    cudaRuntimeGetVersion(&runtimeVersion);
    printf("  CUDA Driver Version / Runtime Version          %d.%d / %d.%d\n",
           driverVersion / 1000, (driverVersion % 100) / 10,
           runtimeVersion / 1000, (runtimeVersion % 100) / 10);
    printf("  CUDA Capability Major/Minor version number:    %d.%d\n",
           deviceProp.major, deviceProp.minor);

    char msg[256];

    sprintf_s(msg, sizeof(msg),
              "  Total amount of global memory:                 %.0f MBytes "
              "(%llu bytes)\n",
              static_cast<float>(deviceProp.totalGlobalMem / 1048576.0f),
              (unsigned long long)deviceProp.totalGlobalMem);
    printf("%s", msg);

    printf("  (%03d) Multiprocessors\n",
           deviceProp.multiProcessorCount);
    printf(
            "  GPU Max Clock rate:                            %.0f MHz (%0.2f "
            "GHz)\n",
            deviceProp.clockRate * 1e-3f, deviceProp.clockRate * 1e-6f);
    printf("  Memory Clock rate:                             %.0f Mhz\n",
           deviceProp.memoryClockRate * 1e-3f);
    printf("  Memory Bus Width:                              %d-bit\n",
           deviceProp.memoryBusWidth);

    if (deviceProp.l2CacheSize) {
        printf("  L2 Cache Size:                                 %d bytes\n",
               deviceProp.l2CacheSize);
    }

    printf(
            "  Maximum Texture Dimension Size (x,y,z)         1D=(%d), 2D=(%d, "
            "%d), 3D=(%d, %d, %d)\n",
            deviceProp.maxTexture1D, deviceProp.maxTexture2D[0],
            deviceProp.maxTexture2D[1], deviceProp.maxTexture3D[0],
            deviceProp.maxTexture3D[1], deviceProp.maxTexture3D[2]);
    printf(
            "  Maximum Layered 1D Texture Size, (num) layers  1D=(%d), %d layers\n",
            deviceProp.maxTexture1DLayered[0], deviceProp.maxTexture1DLayered[1]);
    printf(
            "  Maximum Layered 2D Texture Size, (num) layers  2D=(%d, %d), %d "
            "layers\n",
            deviceProp.maxTexture2DLayered[0], deviceProp.maxTexture2DLayered[1],
            deviceProp.maxTexture2DLayered[2]);

    printf("  Total amount of constant memory:               %zu bytes\n",
           deviceProp.totalConstMem);
    printf("  Total amount of shared memory per block:       %zu bytes\n",
           deviceProp.sharedMemPerBlock);
    printf("  Total shared memory per multiprocessor:        %zu bytes\n",
           deviceProp.sharedMemPerMultiprocessor);
    printf("  Total number of registers available per block: %d\n",
           deviceProp.regsPerBlock);
    printf("  Warp size:                                     %d\n",
           deviceProp.warpSize);
    printf("  Maximum number of threads per multiprocessor:  %d\n",
           deviceProp.maxThreadsPerMultiProcessor);
    printf("  Maximum number of threads per block:           %d\n",
           deviceProp.maxThreadsPerBlock);
    printf("  Max dimension size of a thread block (x,y,z): (%d, %d, %d)\n",
           deviceProp.maxThreadsDim[0], deviceProp.maxThreadsDim[1],
           deviceProp.maxThreadsDim[2]);
    printf("  Max dimension size of a grid size    (x,y,z): (%d, %d, %d)\n",
           deviceProp.maxGridSize[0], deviceProp.maxGridSize[1],
           deviceProp.maxGridSize[2]);
    printf("  Maximum memory pitch:                          %zu bytes\n",
           deviceProp.memPitch);
    printf("  Texture alignment:                             %zu bytes\n",
           deviceProp.textureAlignment);
    printf(
            "  Concurrent copy and kernel execution:          %s with %d copy "
            "engine(s)\n",
            (deviceProp.deviceOverlap ? "Yes" : "No"), deviceProp.asyncEngineCount);
    printf("  Run time limit on kernels:                     %s\n",
           deviceProp.kernelExecTimeoutEnabled ? "Yes" : "No");
    printf("  Integrated GPU sharing Host Memory:            %s\n",
           deviceProp.integrated ? "Yes" : "No");
    printf("  Support host page-locked memory mapping:       %s\n",
           deviceProp.canMapHostMemory ? "Yes" : "No");
    printf("  Alignment requirement for Surfaces:            %s\n",
           deviceProp.surfaceAlignment ? "Yes" : "No");
    printf("  Device has ECC support:                        %s\n",
           deviceProp.ECCEnabled ? "Enabled" : "Disabled");

    printf("  CUDA Device Driver Mode (TCC or WDDM):         %s\n",
           deviceProp.tccDriver ? "TCC (Tesla Compute Cluster Driver)"
                                : "WDDM (Windows Display Driver Model)");

    printf("  Device supports Unified Addressing (UVA):      %s\n",
           deviceProp.unifiedAddressing ? "Yes" : "No");
    printf("  Device supports Managed Memory:                %s\n",
           deviceProp.managedMemory ? "Yes" : "No");
    printf("  Device supports Compute Preemption:            %s\n",
           deviceProp.computePreemptionSupported ? "Yes" : "No");
    printf("  Supports Cooperative Kernel Launch:            %s\n",
           deviceProp.cooperativeLaunch ? "Yes" : "No");
    printf("  Supports MultiDevice Co-op Kernel Launch:      %s\n",
           deviceProp.cooperativeMultiDeviceLaunch ? "Yes" : "No");
    printf("  Device PCI Domain ID / Bus ID / location ID:   %d / %d / %d\n",
           deviceProp.pciDomainID, deviceProp.pciBusID, deviceProp.pciDeviceID);

    const char *sComputeMode[] = {
            "Default (multiple host threads can use ::cudaSetDevice() with device "
            "simultaneously)",
            "Exclusive (only one host thread in one process is able to use "
            "::cudaSetDevice() with this device)",
            "Prohibited (no host thread can use ::cudaSetDevice() with this "
            "device)",
            "Exclusive Process (many threads in one process is able to use "
            "::cudaSetDevice() with this device)",
            "Unknown", nullptr };
    printf("  Compute Mode:\n");
    printf("     < %s >\n", sComputeMode[deviceProp.computeMode]);

    printf("\n");
    std::string sProfileString = "deviceQuery, CUDA Driver = CUDART";
    char cTemp[16];

    // driver version
    sProfileString += ", CUDA Driver Version = ";
    sprintf_s(cTemp, 10, "%d.%d", driverVersion / 1000,
              (driverVersion % 100) / 10);
    sProfileString += cTemp;

    // Runtime version
    sProfileString += ", CUDA Runtime Version = ";
    sprintf_s(cTemp, 10, "%d.%d", runtimeVersion / 1000,
              (runtimeVersion % 100) / 10);
    sProfileString += cTemp;

    printf("%s\n", sProfileString.c_str());

    printf("\n-------------------------- END OF DEVICE INFO --------------------------\n");
}
#pragma endregion

#pragma region Creating vectors
// Функция для создания вектора
double* createVector(int size) {
    auto* array = new double[size];       // Динамическая инициализация матрицы
    for (int i = 0; i < size; i++) {
        array[i] = i + 1.5;
    }
    return array;
}

// Процедура для удаления вектора
void deleteVector(const double* array) {
    delete[] array;
}
#pragma endregion

#pragma region Running CUDA
#pragma region Thread execution
__global__ void kernel(const double* A, double* B, const double* C, const double* D, double* Y, int size)
{
    // Условная координата в выходном векторе для текущего потока
    unsigned int idx_thread = blockIdx.x * blockDim.x + threadIdx.x;
    // Выполнение задачи
    for (int y = 0; y < size; y++)
    {
        Y[idx_thread * size + y] = (A[idx_thread * size + y] + C[idx_thread * size + y]) / (pow(B[idx_thread * size + y], m) - D[idx_thread * size + y]);
    }
}
#pragma endregion
#pragma region Init, run, free
void runCuda(const double* A, const double* B, const double* C, const double* D, double* Y, int size, int GRID_SIZE, int BLOCK_SIZE)
{
#pragma region Time measurement init
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);
#pragma endregion
#pragma region Pointers init
    double *d_A, *d_B, *d_C, *d_D, *d_Y;
    const int forSize = size / (GRID_SIZE * BLOCK_SIZE);
#pragma endregion
#pragma region Memory allocation
    gpuErrchk(cudaMalloc<double>(&d_A, size));
    gpuErrchk(cudaMalloc<double>(&d_B, size));
    gpuErrchk(cudaMalloc<double>(&d_C, size));
    gpuErrchk(cudaMalloc<double>(&d_D, size));
    gpuErrchk(cudaMalloc<double>(&d_Y, size));
#pragma endregion
#pragma region Data copying
    gpuErrchk(cudaMemcpy(d_A, A, size, cudaMemcpyHostToDevice));
    gpuErrchk(cudaMemcpy(d_B, B, size, cudaMemcpyHostToDevice));
    gpuErrchk(cudaMemcpy(d_C, C, size, cudaMemcpyHostToDevice));
    gpuErrchk(cudaMemcpy(d_D, D, size, cudaMemcpyHostToDevice));
    gpuErrchk(cudaMemcpy(d_Y, Y, size, cudaMemcpyHostToDevice));
#pragma endregion
#pragma region Setting sizes of grid&block
    const dim3 block(BLOCK_SIZE);                                   // Размер блока (одномерный)
    const dim3 grid(GRID_SIZE);                                     // Размер сетки из блоков (одномерная)
#pragma endregion
#pragma region Start CUDA
    cudaEventRecord(start);                                         // Запуск таймера
    kernel <<< grid, block >>>(d_A, d_B, d_C, d_D, d_Y, forSize);   // Запуск процедуры
    gpuErrchk(cudaPeekAtLastError());                               // Проверка на ошибки
    cudaEventRecord(stop);                                          // Остановка таймера
#pragma endregion
#pragma region Result copying, free pointers
    cudaMemcpy(Y, d_Y, size, cudaMemcpyDeviceToHost);               // Копирование из памяти видеокарты в память процессора
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    cudaFree(d_D);
    cudaFree(d_Y);
#pragma endregion
#pragma region Time measurement. file output
    cudaEventSynchronize(stop);                                     // Синхронизация таймера
    float time;                                                     // Время
    cudaEventElapsedTime(&time, start, stop);                       // Расчёт времени
    ofstream gpuTime("../gpu.csv", std::ios::app);                  // Открытие файла
    cout << "\nProcessing time for GPU (ms): " << time << "\n";     // Вывод в поток
    // Вывод в файл
    gpuTime << size << "," << BLOCK_SIZE << "," << GRID_SIZE << "," << time << "\n";
    gpuTime.close();                                                // Закрытие файла
#pragma endregion
}
#pragma endregion
#pragma endregion

#pragma region Running CPU
void runCPU(const double* A, const double* B, const double* C, const double* D, double* Y, int size)
{
    for (int i = 0; i < size; i++) {
        Y[i] = (A[i] + C[i]) / (pow(B[i], m) - D[i]);

    }
}
#pragma endregion

int main() {
    // Вывод информации о GPU
    AboutDevice();
#pragma region Variables
    double* A, *B, *C, *D, *Y;                                      // Создание указателей векторов
    vector<int> sizes = {16384, 65536};                             // Список размеров векторов
    // Размеры блоков и их количество
    vector<pair<int,int>> blocks = {{1, 1},{1, 4}, {1, 32}, {1, 64}, {1, 256}, {1, 512},
                                    {2, 1}, {2, 4}, {2, 32}, {2, 64}, {2, 256}, {2, 512},
                                    {4, 1}, {4, 4}, {4, 32}, {4, 64}, {4, 256}, {4, 512},
                                    {8, 1}, {8, 4}, {8, 32}, {8, 64}, {8, 256}, {8, 512},
                                    {16, 1}, {16, 4}, {16, 32}, {16, 64}, {16, 256}, {16, 512}};
#pragma endregion
#pragma region File prep
    ofstream gpuTime("../gpu.csv", std::ios::app);
    ofstream cpuTime("../cpu.csv", std::ios::app);
    gpuTime << "Размер массивов, размер блока, количество блоков, время (мс)" << "\n";
    cpuTime << "Размер массивов, время (мс)" << "\n";
#pragma endregion
#pragma region Main programm
    cout << "\n-------------------------- PROCESSING STARTED --------------------------\n";
    for (const auto &size : sizes) {
#pragma region Vectors creation
        cout << "MATRIX SIZE: " << size << "\n";
        A = createVector(size);
        B = createVector(size);
        C = createVector(size);
        D = createVector(size);
        Y = new double[size];
        cout << "MATRICES CREATED\n";
#pragma endregion
#pragma region Run CUDA
        cout << "\n-------------------------- CUDA PART STARTED --------------------------\n";
        for (const auto &block : blocks) {
            runCuda(A, B, C, D, Y, size, block.first, block.second);
        }
        cout << "\n-------------------------- CUDA PART FINISHED --------------------------\n";
#pragma endregion
#pragma region Run CPU
        cout << "\n-------------------------- CPU PART STARTED --------------------------\n";
        double time = measureExecutionTime([&]() {runCPU(A, B, C, D, Y, size);});
        cout << "\nProcessing time for CPU (ms): " << time << "\n";
        cpuTime << size << "," << time << "\n";
        cout << "\n-------------------------- CPU PART FINISHED --------------------------\n";
#pragma endregion
#pragma region Memory free
        deleteVector(A);
        deleteVector(B);
        deleteVector(C);
        deleteVector(D);
        deleteVector(Y);
#pragma endregion
    }
    cout << "\n-------------------------- PROCESSING FINISHED --------------------------\n";
#pragma endregion
#pragma region File closing
    gpuTime.close();
    cpuTime.close();
#pragma endregion
    return 0;
}
