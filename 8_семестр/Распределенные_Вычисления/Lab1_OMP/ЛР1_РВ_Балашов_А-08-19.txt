// Балашов Савва, А-08-19
// Apple clang version 14.0.0 (clang-1400.0.29.202)
// Target: arm64-apple-darwin22.2.0
// Thread model: posix
// InstalledDir: /Library/Developer/CommandLineTools/usr/bin
// 10 ядер / 10 потоков

// Написать программу на языке C в стандарте OpenMP, для параллельного выполнения поставленной ниже задачи.
// В программе создать двухмерный массивы A [16*N;16*N], где N – номер варианта по списку группы. Создать в программе две параллельные области.
// В первой параллельной области заполнить массив A исходными данными (любым способом). Во второй параллельной области найти сумму элементов массива A. Вывести итог на экран.
// Вторую параллельную область организовать по примеру 1 (см. пример 1 в презентации).

#include <iostream>
#include "/opt/homebrew/Cellar/libomp/15.0.7/include/omp.h"

int main()
{
    int N = 4;
    int sz = 16*N;
    int A[sz][sz];
    srand(time(nullptr));
    long sum = 0;

    int thread_num = 8;
    omp_set_num_threads(thread_num);

    int thread_id = 0;

#pragma omp parallel private(thread_id)
    {
        thread_id = omp_get_thread_num();
        for (int i = 0; i < sz; ++i) {
            for (int j = 0; j < sz; ++j) {
                A[i][j] = rand();
                std::cout << "A[" << i << "][" << j << "]= " << A[i][j] << " ";
            }
            std::cout << std::endl;
        }
    }

#pragma omp parallel private (thread_id)
    {
        thread_id = omp_get_thread_num();
        int thread_count = omp_get_num_threads();
        int thread_elems = sz/thread_count;
        for (int j = thread_elems*thread_id; j < thread_elems*thread_id + thread_elems; ++j) {
            for (int i = 0; i < sz; ++i) {
                sum += A[i][j];
            }
        }

    }

    std::cout << "Sum of elements of A[][] = " << sum << std::endl;
//    system("read -n 1 -s -p\"Press any key to continue...\"");
    return 0;
}
