#include <iostream>
#include <vector>
#include <fstream>
#include <chrono>
#include <cuda_runtime.h>

#define N 512
#define M 60*7
#define bigN 65536          // 64 KB
#define coeff 64
#define CAP (bigN / coeff)  // 4 KB for 4 arrays

using namespace std;
using namespace std::chrono;

// Macros to check CUDA errors that are not shown by compiler (simple check of cuda success)
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

int A[N], B[N];
double X[N], C[N];

int bigA[bigN], bigB[bigN];
double bigX[bigN], bigC[bigN];

void fillArrays(int *a, int *b, double *c, double *x) {
    for (int i = 0; i < N; i++) {
        a[i] = 2;
        b[i] = 1;
        c[i] = 1.5;
        x[i] = 1.0;
    }
}

void fillBigArrays(int *a, int *b, double *c, double *x) {
    for (int i = 0; i < bigN; i++) {
        a[i] = 2;
        b[i] = 1;
        c[i] = 1.5;
        x[i] = 1.0;
    }
}

void hostWork(const int *a, const int *b, const double *c, double *x) {
    for (int i = 0; i < N; i++) {
        for (int j = 0; j < M; j++) {
            x[i] = (double) a[i] * (x[i] + b[j]) / c[j];
        }
    }
}

__global__ void globalMemoryGPU(const int *a, const int *b, const double *c, double *x, int size) {
    uint8_t i = threadIdx.x + blockIdx.x * blockDim.x;
    for (int y = 0; y < size; y++) {
        int bigIndex = i * size + y;
        for (int j = 0; j < M; j++) {
            x[bigIndex] = (double) a[bigIndex] * (x[bigIndex] + b[bigIndex]) / c[bigIndex];
        }
    }
}

__global__ void sharedMemoryGPU(const int *a, const int *b, const double *c, double *x, int size) {
    __shared__ double sharedX[N];
    __shared__ int sharedA[N];
    __shared__ int sharedB[N];
    __shared__ double sharedC[N];
    uint8_t i = threadIdx.x + blockIdx.x * blockDim.x;
    for (int y = 0; y < size; y++) {
        int bigIndex = i * size + y;
        sharedA[bigIndex] = a[bigIndex];
        sharedB[bigIndex] = b[bigIndex];
        sharedC[bigIndex] = c[bigIndex];
        sharedX[bigIndex] = x[bigIndex];
        __syncthreads();
        for (int j = 0; j < M; j++) {
            sharedX[bigIndex] = (double) sharedA[bigIndex] * (sharedX[bigIndex] + sharedB[bigIndex]) / sharedC[bigIndex];
        }
        __syncthreads();
        x[bigIndex] = sharedX[bigIndex];
    }
}

__constant__ int constantA[N];
__constant__ int constantB[N];
__constant__ double constantC[N];

__global__ void constantMemoryGPU(double *x, int size) {
    __shared__ double sharedX[N];
    uint8_t i = threadIdx.x + blockIdx.x * blockDim.x;
    for (int y = 0; y < size; y++) {
        int bigIndex = i * size + y;
        sharedX[bigIndex] = x[bigIndex];
        __syncthreads();
        for (int j = 0; j < M; j++) {
            sharedX[bigIndex] = (double) constantA[bigIndex] * (sharedX[bigIndex] + constantB[bigIndex]) / constantC[bigIndex];
        }
        __syncthreads();
        x[bigIndex] = sharedX[bigIndex];
    }
}

__global__ void sharedMemoryCapGPU(const int *a, const int *b, const double *c, double *x, int size, int cap_size) {
    uint8_t i = threadIdx.x + blockIdx.x * blockDim.x;

    for (int r = 0; r < coeff; r++) {
        __shared__ double sharedX[CAP];
        __shared__ int sharedA[CAP];
        __shared__ int sharedB[CAP];
        __shared__ double sharedC[CAP];

        for (int y = 0; y < cap_size; y++) {
            int capIndex = i * cap_size + y;
            int bigIndex = capIndex + r * CAP;
            sharedA[capIndex] = a[bigIndex];
            sharedB[capIndex] = b[bigIndex];
            sharedC[capIndex] = c[bigIndex];
            sharedX[capIndex] = x[bigIndex];
            __syncthreads();
            for (int j = 0; j < M; j++) {
                sharedX[capIndex] = (double) sharedA[capIndex] * (sharedX[capIndex] + sharedB[capIndex]) / sharedC[capIndex];
            }
            __syncthreads();
            x[bigIndex] = sharedX[capIndex];
        }
    }
}

__constant__ int constantBigA[CAP];
__constant__ int constantBigB[CAP];
__constant__ double constantBigC[CAP];

__global__ void constantMemoryCapGPU(double *x, int size, int cap_size, int cap_index) {
   uint8_t i = threadIdx.x + blockIdx.x * blockDim.x;
    __shared__ double sharedX[CAP];
   for (int y = 0; y < cap_size; y++) {
        int capIndex = i * cap_size + y;
        int bigIndex = capIndex + cap_index * CAP;
        sharedX[capIndex] = x[bigIndex];
        __syncthreads();
        for (int j = 0; j < M; j++) {
            sharedX[capIndex] = (double) constantBigA[capIndex] * (sharedX[capIndex] + constantBigB[capIndex]) / constantBigC[capIndex];
        }
        __syncthreads();
        x[bigIndex] = sharedX[capIndex];
    }
}

void runCUDA(const int GRID_SIZE, const int BLOCK_SIZE) {
    cudaEvent_t start, stop;
    cudaEventCreate(&start);
    cudaEventCreate(&stop);


    int *d_A, *d_B;
    double *d_C, *d_X;
    const int forSize = N / (GRID_SIZE * BLOCK_SIZE);
    const dim3 block(BLOCK_SIZE);                                   // Размер блока (одномерный)
    const dim3 grid(GRID_SIZE);                                     // Размер сетки из блоков (одномерная)

    fillArrays(A, B, C, X);

    cout << "\n-------------------------- GLOBAL PART STARTED --------------------------\n";
    checkCUDA(cudaMalloc(&d_A, N * sizeof(int)));
    checkCUDA(cudaMalloc(&d_B, N * sizeof(int)));
    checkCUDA(cudaMalloc(&d_C, N * sizeof(double)));
    checkCUDA(cudaMalloc(&d_X, N * sizeof(double)));

    checkCUDA(cudaMemcpy(d_A, A, N * sizeof(int), cudaMemcpyHostToDevice));
    checkCUDA(cudaMemcpy(d_B, B, N * sizeof(int), cudaMemcpyHostToDevice));
    checkCUDA(cudaMemcpy(d_C, C, N * sizeof(double), cudaMemcpyHostToDevice));
    checkCUDA(cudaMemcpy(d_X, X, N * sizeof(double), cudaMemcpyHostToDevice));

    cudaEventRecord(start);                                         // Запуск таймера
    globalMemoryGPU <<< grid, block >>>(d_A, d_B, d_C, d_X, forSize);   // Запуск процедуры
    checkCUDA(cudaPeekAtLastError());                               // Проверка на ошибки
    cudaEventRecord(stop);                                          // Остановка таймера

    checkCUDA(cudaMemcpy(X, d_X, N * sizeof(double), cudaMemcpyDeviceToHost));
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    cudaFree(d_X);

    cudaEventSynchronize(stop);                                     // Синхронизация таймера
    float time;                                                     // Время
    cudaEventElapsedTime(&time, start, stop);                       // Расчёт времени
    ofstream globalTime("../gpu_global.csv", std::ios::app);                  // Открытие файла
    cout << "\nProcessing time for global memory GPU (ms): " << time << "\n";     // Вывод в поток
    // Вывод в файл
    globalTime << N << "," << BLOCK_SIZE << "," << GRID_SIZE << "," << time << "\n";
    globalTime.close();                                                // Закрытие файла
    cout << "\n-------------------------- GLOBAL PART ENDED --------------------------\n";
    cudaDeviceSynchronize();

    cout << "\n-------------------------- SHARED PART STARTED --------------------------\n";
    fillArrays(A, B, C, X);

    checkCUDA(cudaMalloc(&d_A, N * sizeof(int)));
    checkCUDA(cudaMalloc(&d_B, N * sizeof(int)));
    checkCUDA(cudaMalloc(&d_C, N * sizeof(double)));
    checkCUDA(cudaMalloc(&d_X, N * sizeof(double)));

    checkCUDA(cudaMemcpy(d_A, A, N * sizeof(int), cudaMemcpyHostToDevice));
    checkCUDA(cudaMemcpy(d_B, B, N * sizeof(int), cudaMemcpyHostToDevice));
    checkCUDA(cudaMemcpy(d_C, C, N * sizeof(double), cudaMemcpyHostToDevice));
    checkCUDA(cudaMemcpy(d_X, X, N * sizeof(double), cudaMemcpyHostToDevice));

    cudaEventRecord(start);                                         // Запуск таймера
    sharedMemoryGPU <<< grid, block >>>(d_A, d_B, d_C, d_X, forSize);   // Запуск процедуры
    checkCUDA(cudaPeekAtLastError());                               // Проверка на ошибки
    cudaEventRecord(stop);                                          // Остановка таймера

    checkCUDA(cudaMemcpy(X, d_X, N * sizeof(double), cudaMemcpyDeviceToHost));
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    cudaFree(d_X);

    cudaEventSynchronize(stop);                                     // Синхронизация таймера
    cudaEventElapsedTime(&time, start, stop);                       // Расчёт времени
    ofstream sharedTime("../gpu_shared.csv", std::ios::app);                  // Открытие файла
    cout << "\nProcessing time for shared memory GPU (ms): " << time << "\n";     // Вывод в поток
    // Вывод в файл
    sharedTime << N << "," << BLOCK_SIZE << "," << GRID_SIZE << "," << time << "\n";
    sharedTime.close();                                                // Закрытие файла
    cout << "\n-------------------------- SHARED PART FINISHED --------------------------\n";
    cudaDeviceSynchronize();

    cout << "\n-------------------------- CONSTANT PART STARTED --------------------------\n";
    fillArrays(A, B, C, X);

    checkCUDA(cudaMalloc(&d_X, N * sizeof(double)));

    checkCUDA(cudaMemcpyToSymbol(constantA, A, N * sizeof(int)));
    checkCUDA(cudaMemcpyToSymbol(constantB, B, N * sizeof(int)));
    checkCUDA(cudaMemcpyToSymbol(constantC, C, N * sizeof(double)));
    checkCUDA(cudaMemcpy(d_X, X, N * sizeof(double), cudaMemcpyHostToDevice));

    cudaEventRecord(start);                                         // Запуск таймера
    constantMemoryGPU <<< grid, block >>>(d_X, forSize);   // Запуск процедуры
    checkCUDA(cudaPeekAtLastError());                               // Проверка на ошибки
    cudaEventRecord(stop);                                          // Остановка таймера

    checkCUDA(cudaMemcpy(X, d_X, N * sizeof(double), cudaMemcpyDeviceToHost));
    cudaFree(d_X);

    cudaEventSynchronize(stop);                                     // Синхронизация таймера
    cudaEventElapsedTime(&time, start, stop);                       // Расчёт времени
    ofstream constantTime("../gpu_const.csv", std::ios::app);                  // Открытие файла
    cout << "\nProcessing time for constant memory GPU (ms): " << time << "\n";     // Вывод в поток
    // Вывод в файл
    constantTime << N << "," << BLOCK_SIZE << "," << GRID_SIZE << "," << time << "\n";
    constantTime.close();                                                // Закрытие файла
    cout << "\n-------------------------- CONSTANT PART ENDED --------------------------\n";
    cudaDeviceSynchronize();

    cout << "\n-------------------------- SHARED CAP PART STARTED --------------------------\n";
    fillBigArrays(bigA, bigB, bigC, bigX);
    const int forBigSize = bigN / (GRID_SIZE * BLOCK_SIZE);
    const int forCapSize = CAP / (GRID_SIZE * BLOCK_SIZE);

    checkCUDA(cudaMalloc(&d_A, bigN * sizeof(int)));
    checkCUDA(cudaMalloc(&d_B, bigN * sizeof(int)));
    checkCUDA(cudaMalloc(&d_C, bigN * sizeof(double)));
    checkCUDA(cudaMalloc(&d_X, bigN * sizeof(double)));

    checkCUDA(cudaMemcpy(d_A, bigA, bigN * sizeof(int), cudaMemcpyHostToDevice));
    checkCUDA(cudaMemcpy(d_B, bigB, bigN * sizeof(int), cudaMemcpyHostToDevice));
    checkCUDA(cudaMemcpy(d_C, bigC, bigN * sizeof(double), cudaMemcpyHostToDevice));
    checkCUDA(cudaMemcpy(d_X, bigX, bigN * sizeof(double), cudaMemcpyHostToDevice));

    cudaEventRecord(start);                                         // Запуск таймера
    sharedMemoryCapGPU <<< grid, block >>>(d_A, d_B, d_C, d_X, forBigSize, forCapSize);   // Запуск процедуры
    checkCUDA(cudaPeekAtLastError());                               // Проверка на ошибки
    cudaEventRecord(stop);                                          // Остановка таймера

    checkCUDA(cudaMemcpy(bigX, d_X, bigN * sizeof(double), cudaMemcpyDeviceToHost));
    cudaFree(d_A);
    cudaFree(d_B);
    cudaFree(d_C);
    cudaFree(d_X);

    cudaEventSynchronize(stop);                                     // Синхронизация таймера
    cudaEventElapsedTime(&time, start, stop);                       // Расчёт времени
    ofstream capSharedTime("../gpu_shared_cap.csv", std::ios::app);                  // Открытие файла
    cout << "\nProcessing time for shared cap memory GPU (ms): " << time << "\n";     // Вывод в поток
    // Вывод в файл
    capSharedTime << bigN << "," << BLOCK_SIZE << "," << GRID_SIZE << "," << time << "\n";
    capSharedTime.close();                                                // Закрытие файла
    cout << "\n-------------------------- SHARED CAP PART ENDED --------------------------\n";
    cudaDeviceSynchronize();

    cout << "\n-------------------------- CONSTANT CAP PART STARTED --------------------------\n";
    fillBigArrays(bigA, bigB, bigC, bigX);

    checkCUDA(cudaMalloc(&d_X, bigN * sizeof(double)));

    checkCUDA(cudaMemcpy(d_X, bigX, bigN * sizeof(double), cudaMemcpyHostToDevice));


    /// CONSTANT CAP
    cudaEventRecord(start);                                         // Запуск таймера
    for (int i = 0; i < coeff; ++i)
    {
        checkCUDA(cudaMemcpyToSymbol(constantBigA, bigA + coeff, CAP * sizeof(int)));
        checkCUDA(cudaMemcpyToSymbol(constantBigB, bigB + coeff, CAP * sizeof(int)));
        checkCUDA(cudaMemcpyToSymbol(constantBigC, bigC + coeff, CAP * sizeof(double)));
        constantMemoryCapGPU <<< grid, block >>>(d_X, forBigSize, forCapSize, coeff);   // Запуск процедуры
    }
    checkCUDA(cudaPeekAtLastError());                               // Проверка на ошибки
    cudaEventRecord(stop);                                          // Остановка таймера

    checkCUDA(cudaMemcpy(X, d_X, bigN * sizeof(double), cudaMemcpyDeviceToHost));
    cudaFree(d_X);

    cudaEventSynchronize(stop);                                     // Синхронизация таймера
    cudaEventElapsedTime(&time, start, stop);                       // Расчёт времени
    ofstream capConstantTime("../gpu_const_cap.csv", std::ios::app);                  // Открытие файла
    cout << "\nProcessing time for constant cap memory GPU (ms): " << time << "\n";     // Вывод в поток
    // Вывод в файл
    capConstantTime << bigN << "," << BLOCK_SIZE << "," << GRID_SIZE << "," << time << "\n";
    capConstantTime.close();                                                // Закрытие файла
    cout << "\n-------------------------- CONSTANT CAP PART ENDED --------------------------\n";
}

int main() {
    cout << "\n-------------------------- PROCESSING STARTED --------------------------\n";
    fillArrays(A, B, C, X);
    cout << "\n-------------------------- CPU PART STARTED --------------------------\n";
    double time = measureExecutionTime([&](){ hostWork(A, B, C, X);});
    ofstream cpuTime("../cpu.csv", std::ios::app);
    cout << "\nProcessing time for CPU (ms): " << time << "\n";
    cpuTime << N << "," << time << "\n";
    cpuTime.close();
    cout << "\n-------------------------- CPU PART FINISHED --------------------------\n";

    vector<int> block_sizes = {1, 4, 32, 128, 256};
    vector<int> grid_sizes = {1, 2, 4};

    cout << "\n-------------------------- CUDA PART STARTED --------------------------\n";
    for (const auto &grid : grid_sizes) {
        for (const auto &block : block_sizes) {
            runCUDA(grid, block);
        }
    }
    cout << "\n-------------------------- CUDA PART FINISHED --------------------------\n";
    cout << "\n-------------------------- PROCESSING FINISHED --------------------------\n";

    return 0;
}
