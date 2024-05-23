//-----------------------------------------------------------------------
#include <cstdio>      // printf, scanf
#include <conio.h>      // getch
#include <cmath>       // fabs, pow, ceil\floor, log, log10, exp, sqrt
#include <cstdlib>     // randomize, rand
#include <ctime>       //Time for random


//---------------------------------------------------------------------------
const double xx[7] = { 0.00001, -0.99, -1, -0.1, 0.1, 1, 0.99 };
#pragma warning(disable: 4996)
#pragma argsused
int main()
{
    int n, i, k, z;
    double e, sl, s2, sum, f, *x; // четыре простого типа и один – дин.массив(указатель)
    srand(time(nullptr));

    printf("Enter e=? ");
    scanf("%lf", &e);  // ввод числа с плавающей точкой двойной точности(%lf) e
    if (e < 1e-13 || e>0.11) {
        printf("Incorrect accuracy of e (0..0.1] \nPress any key");
        _getch(); // ожидание нажатия клавиши
        return 0;  // выход из функции main
    }
    fflush(stdin);  // очищаем буфер (лишние символы после ввода e)

    printf("Enter n=? ");
    scanf("%d", &n);  // ввод десятичного(%d) n
    if (n < 1 || n>20) {
        printf("Invalid n [1..20]! \nPress any key");
        _getch(); // ожидание нажатия клавиши
        return 0;  // выход из функции main
    }
    fflush(stdin);

    x = new double[n];  // выделяем память для n элементов массива

    printf("Enter n=%d values of X from (-1,+1):\n", n);
    for (i = 0; i < n; i++) {     // ввод x[0]...x[n-1]
        scanf("%lf", &x[i]);       // типа long float (%lf)

        if (fabs(x[i]) >= 1) {
            x[i] = xx[rand() % 7]; // одно из семи значений массива xx
            if (fabs(x[i]) == 1) {
                x[i] = x[i] * (rand() % 100) / 100;
                if (x[i] == 0) x[i] = e; // для некоторых вариантов x=/=0
            }
            printf("Incorrect value was  replaced with %15.10lf\n", x[i]);
        }

    }


    z = ceil(fabs(log(e) / log(10.0))) + 1;     //Округление до ближайшего целого числа, не меньшего исходного

    printf("e = %*.*lf\n", z + 2, z, e); // вывод e:(z+2):z
    printf("N |        X        |      Sum(X)     | K|       F(X)      |  |Sum(X)-F(X)|\n");
    for (i = 1; i < 80; i++) printf("="); printf("\n");
    for (i = 0; i < n; i++) {

        // поиск суммы ряда
        sl = s2 = pow(x[i], 2); // sl=pow(x[i],2); sum=sl;  // первое слагаемое
        sum = sl + s2;
        k = 1;
        while ((fabs(sl) >= e) && (k != 500)) {
            sl *= -pow(x[i], 2) / (4 *pow(k, 2) + 2 * k);
            s2 *= -pow(x[i], 2) / (k + 1);
            sum += sl + s2;
            k++;
        };

        f = x[i] * sin(x[i]) - pow(exp(1.0), -pow(x[i], 2)) + 1;

        printf("%2d|%17.*lf|%17.*lf|%2d|%17.*lf|%17.*lf\n",
               i + 1, z, x[i], z, sum, k, z, f, z + 2, fabs(sum - f));
    }

    delete[] x; //  освобождение памяти для одномерного дин.массива

    printf("Press any key");
    _getch();
    return 0;
}