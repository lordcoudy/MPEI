#include <stdio.h>
// SSE (V2)
#include <emmintrin.h>
#include <time.h>

#define ITERATIONS 1000

#define N 8
#define M 4
#define k (M+N)

// функция без использования SSE
double calc_standart(double* x, double* y, int n)
{
    double s = 0;

    for (int i = 0; i < n; i++)
    {
        s += x[i] * y[i];
    }

    return s;
}

// функция с использованием SSE
double calc_sse(double* x, double* y, int n)
{
    double sum;
    __m128d* xx, * yy;
    __m128d p, s;
    xx = (__m128d*)x;
    yy = (__m128d*)y;
    s = _mm_set_pd(0, 0);

    for (int i = 0; i < n / 2; i++)
    {
        p = _mm_mul_pd(xx[i], yy[i]);   // векторное умножение четырех чисел
        s = _mm_add_pd(s, p);           // векторное сложение четырех чисел
    }

    p = _mm_shuffle_pd(s, s, 1);        // перемещение второго значения в s в младшую позицию в p
    s = _mm_add_pd(s, p);               // скалярное сложение
    _mm_store_sd(&sum, s);              // запись младшего значения в память;
    return sum;
}

int main()
{
    double s;

    const int sizes[] = { 200000 };
    for (int w = 0; w < sizeof(sizes) / sizeof(int); w++) {
        int L = sizes[w];
        printf("L:%d\n", L);
        // выделение памяти с выравниванием
        double* x = (double*)_mm_malloc(L * sizeof(double), 16);
        double* y = (double*)_mm_malloc(L * sizeof(double), 16);

        if (x && y) {
            for (int i = 0; i < L; i++)
            {
                x[i] = N + i;
                y[i] = M + i;
            }
        }

        double time_spent = 0.0;
        printf("Size of arrays %d\n\n", L);
        clock_t begin = clock();

        for (int itt1 = 0; itt1 < ITERATIONS; itt1++)
        {
            s = calc_standart(x, y, L);
        }
        printf("\tResult: %.0f\n", s);

        clock_t end = clock();
        time_spent += (double)(end - begin) / CLOCKS_PER_SEC;
        printf("\tThe elapsed time is %f seconds\n", time_spent);

        time_spent = 0.0;
        begin = clock();

        // Using SSE
        for (int itt2 = 0; itt2 < ITERATIONS; itt2++)
        {
            s = calc_sse(x, y, L);
        }
        printf("\tResult: %.0f\n", s);

        end = clock();
        time_spent += (double)(end - begin) / CLOCKS_PER_SEC;
        printf("\tThe elapsed time is %f seconds\n\n", time_spent);

        _mm_free(x);
        _mm_free(y);
    }

    return 0;
}