#include <stdio.h>
#include <time.h>
#define N 8
#define M 4
#define L 4000
#define k (M+N)
// «обычная» функция
double inner1(double* x, double* y, double* A, int n)
{
    double s;
    int i;
    s = 0;
    for (i = 0; i < n; i++)
    {
        for (int j = 0; j < n; ++j)
        {
            s += k * A[i * L + j] * x[i] + y[i];
        }
    }
    return s;
}
// функция с использованием SSE
double inner2(double* x, double* y, double* A, int n)
{
    double sum;
    int i;
    __m128d* xx, * yy, * AA;
    __m128d p, s, kk, tm1, tm2;
    xx = (__m128d*)x;
    yy = (__m128d*)y;
    AA = (__m128d*)A;
    s = _mm_set_pd1(0);
    kk = _mm_set_pd1(k);
    for (i = 0; i < n / 4; i++)
    {
        for (int j = 0; j < n; j++)
        {
            tm1 = _mm_mul_pd(xx[i], AA[i * L + j]); // векторное умножение четырех чисел
            tm2 = _mm_mul_pd(tm1, kk);     
            p = _mm_add_pd(tm2, yy[i]);      // векторное сложение четырех чисел
            s = _mm_add_pd(s, p);          
        }
    }
    p = _mm_movehl_pd(p, s);    // перемещение двух старших значений s в младшие p
    s = _mm_add_pd(s, p);               // векторное сложение
    p = _mm_shuffle_pd(s, s, 1);// перемещение второго значения в s в младшую позицию в p
    s = _mm_add_sd(s, p);               // скалярное сложение
    _mm_store_sd(&sum, s);              // запись младшего значения в память;
    return sum;
}
int main()
{
    double* x, * y, * A, s;
    long t;
    int i;
    // выделение памяти с выравниванием
    x = (double*)_mm_malloc(L * sizeof(double), 16);
    y = (double*)_mm_malloc(L * sizeof(double), 16);
    A = (double*)_mm_malloc(L * L * sizeof(double), 16);
    for (i = 0; i < L; i++)
    {
        x[i] = N + i;
        y[i] = M + i;
        for (int j = 0; j < L; ++j)
        {
            A[i * L + j] = N + M + j + i;
        }
    }
    double time_spent = 0.0;
    clock_t begin = clock();
    // Using x87
    for (int itt1 = 0; itt1 < 1000; itt1++)
    {
        s = inner1(x, y, A, L);
    }
    printf("Result: %f\n", s);
    clock_t end = clock();
    time_spent += (double)(end - begin) / CLOCKS_PER_SEC;
    printf("The elapsed time is %f seconds\n", time_spent);
    time_spent = 0.0;
    begin = clock();
    // Using SSE
    for (int itt2 = 0; itt2 < 1000; itt2++)
    {
        s = inner2(x, y, A, L);
    }
    printf("Result: %f\n", s);
    end = clock();
    time_spent += (double)(end - begin) / CLOCKS_PER_SEC;
    printf("The elapsed time is %f seconds\n", time_spent);
    _mm_free(x);
    _mm_free(y);
    return 0;
}
