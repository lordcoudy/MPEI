#include <cstdio>
#include <cmath>
#include <cstdlib>
#include "methodsFunc.h"

int main() {
    printf("Enter A, B\n");     // Запрос ввода концов отрезка
    int n;
    double a,b;
    try {
        scanf("%lf", &a);       // Чтение левого края отрезка с клавиатуры
        if (a<=0) throw 1; if (a>=2) throw 2; // Проверка на аномалии (левый конец отрезка не должен быть меньше 0 или равен/больше 2) с выдачей кода ошибки
        scanf("%lf", &b);
        if (b<=0) throw 3; if (b>=2) throw 4;// Проверка на аномалии (правый конец отрезка не должен быть меньше 0 или равен/больше 2) с выдачей кода ошибки
        if (b<a) throw 5;   // Проверка на аномалии (правый конец отрезка не должен быть меньше левого) с выдачей кода ошибки
        fflush(stdin);
        printf("Enter number of tries\n");  // Запрос на ввод количества погрешностей
        scanf("%d", &n); if (n<1) throw 6; if (n>10) throw 7; // Проверка на аномалии (количество погрешностей не должно быть меньше 1 или больше 10) с выдачей кода ошибки
        double e[n];       // Массив из погрешностей
        for (int i = 0; i < n; i++) {   // Заполнение массива погрешностей
            printf("Accuracy[%d]=", i + 1);
            scanf("%lf", &e[i]);
            if (floor(e[i]*pow(10,10))==0) throw 8 + i;     // Проверка на аномалии (Погрешность не должна быть слишком маленькой) с выдачей кода ошибки
            fflush(stdin);
        }
        printf("For the First function:\n");
        TableStart(2, a, b);    // Начало таблцы
        for (int i = 0; i < n; i++) {   // Поиск корня
            int n1 = 0;
            int n2 = 0;
            double x1 = FindRootDiv(a, b, e[i], func2, &n1);    // Деление пополам
            double x2 = FindRootNewt(a, b, e[i], func2, &n2);   // Метод Ньютона
            TableCell(e[i], x1, n1, x2, n2);    // Вывод в таблицу
        }
        printf("For the Second function:\n");
        TableStart(5, a, b);    // Заголовок таблцы
        for (int i = 0; i < n; i++) {   // Поиск корня
            int n1 = 0;
            int n2 = 0;
            double x1 = FindRootDiv(a, b, e[i], func5, &n1);    // Деление пополам
            double x2 = FindRootNewt(a, b, e[i], func5, &n2);   // Метод Ньютона
            TableCell(e[i], x1, n1, x2, n2);    // Вывод в таблицу
        }
    }
    catch (int errNum) {        // Расшифровка кодов ошибок
        switch (errNum){
            default:            // По умолчанию (код больше 7)
                errNum-=7;
                printf("Accuracy[%d] is too little\n",errNum);
                break;
            case 1:             // Код ошибки 1
                printf("\'A\' should be bigger than 0\n");
                break;
            case 2:             // Код ошибки 2
                printf("\'A\' should be lesser than 2\n");
                break;
            case 3:             // Код ошибки 3
                printf("\'B\' should be bigger than 0\n");
                break;
            case 4:             // Код ошибки 4
                printf("\'B\' should be lesser than 2\n");
                break;
            case 5:             // Код ошибки 5
                printf("\'A\' should not be bigger than \'B\'\n");
                break;
            case 6:             // Код ошибки 6
                printf("\'N\' should be bigger than 1\n");
                break;
            case 7:             // Код ошибки 7
                printf("\'N\' should be lesser than 10\n");
                break;
        }
    }
    printf("------------------------------------------------------------\nPress ENTER"); getc(stdin);
    return 0;
}