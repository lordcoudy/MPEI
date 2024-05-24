#include <stdio.h>
#include <emmintrin.h>
#include <time.h>

#define N 8
#define M 4
#define k (M+N)

// «обычная» функция
double* inner1(double* x, double* y, double** A, int n)
{
    double* s;
    int i;
    s = (double*)calloc(n, sizeof(double));

    for (i = 0; i < n; ++i)
    {
        for (int j = 0; j < n; ++j)
        {
            s[i] += k * A[i][j] * x[i] + y[i];
        }
    }
    return s;
}

// функция с использованием SSE
double* inner2(double* x, double* y, double** A, int n)
{
    double* sum;
    sum = (double*)calloc(n, sizeof(double));
    int i, j;

    __m128d *xx, *yy, **AA, p, s, kk, tm1, tm2;

    xx = (__m128d*)x;
    yy = (__m128d*)y;
    AA = (__m128d**)A;

    s = _mm_set1_pd(0);
    p = _mm_set1_pd(0);

    kk = _mm_set1_pd(k);
    
    for (i = 0; i < n; i++)
    {
        tm1 = _mm_set1_pd(0);
        tm2 = _mm_set1_pd(0);
        for (j = 0; j < n/2; j++)
        {
            p = _mm_mul_pd(AA[i][j], xx[j]);
            tm1 = _mm_add_pd(tm1, p);
            tm2 = _mm_add_pd(tm2, yy[j]);
        }
        tm1 = _mm_mul_pd(tm1, kk);
        s = _mm_add_pd(tm1, tm2);
        p = _mm_shuffle_pd(s, s, 1);
        s = _mm_add_pd(s, p);
        _mm_store_sd(&sum[i], s);
    }
    return sum;
}

int main()
{
    const int sizes[] = { 40, 400, 4000};
    for (int w = 0; w < 5; w++) {
        int L = sizes[w];
        double* x, * y, **A, *s, result;
        int i, j;
        // выделение памяти с выравниванием
        x = (double*)_mm_malloc(L * sizeof(double), 16);
        y = (double*)_mm_malloc(L * sizeof(double), 16);
        A = (double**)malloc(L * sizeof(double*));
        for (i = 0; i < L; i++)  // цикл по строкам
            {
                A[i] = (double*)_mm_malloc(L * sizeof(double), 16);
            }
        s = (double*)calloc(L, sizeof(double));
        if (x && y && A) {
            for (i = 0; i < L; i++)
            {
                x[i] = (double)(N + i);
                y[i] = (double)(M + i);
                if (A[i]) {
                    for (j = 0; j < L; j++)
                    {
                        A[i][j] = (double)(N + M + i + j);
                    }
                }
            }
        }  
        double time_spent = 0.0;
        printf("Size of arrays %d\n\n", L);
        clock_t begin = clock();
        // Using x87
        for (int itt1 = 0; itt1 < 1000; itt1++)
        {
            s = inner1(x, y, A, L);
        }

        result = 0;
        printf("STANDART FUNCTION\n");
        printf("\tResult:\n\t");
        for (i = 0; i < L; i++)
        {
            result += s[i];
        }
        printf("%.0f\n", result);
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
        result = 0;
        printf("\nFUNCTION WITH SSE2\n");
        printf("\tResult:\n\t");
        for (i = 0; i < L; i++)
        {
            result += s[i];
        }
        printf("%.0f\n", result);
        end = clock();
        time_spent += (double)(end - begin) / CLOCKS_PER_SEC;
        printf("The elapsed time is %f seconds\n", time_spent);
        _mm_free(x);
        _mm_free(y);
        for (i = 0; i < L; i++)
        {
            _mm_free(A[i]);
        }
        free(A);
        free(s);
    }
    return 0;
}
