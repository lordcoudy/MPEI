#ifndef PRAC_METHODS_H
#define PRAC_METHODS_H

#include <algorithm>

//// Простой поиск поэлементно
double simp(const double a[], int n)
{
    double min = a[0];
    for (int i = 1; i < n; i++) {
        if (a[i]<min)
            min = a[i];
    }
    return min;
}

//// Метод поиска с запоминанием индекса
double index(const double a[], int n)
{
    int imin = 0;
    for (int i = 1; i < n; i++) {
        if (a[i]<a[imin])
            imin = i;
    }
    return a[imin];
}

//// Экспериментальный метод сравнения
double bigger(const double a[], int n)
{
    double minValue = -1.7976931348623157E+308;
    int imin;
    for (int i = 0; i < n; i++) {
        a[i] != minValue ? minValue + 2.22507E-308 : (imin = i);
    }
    return a[imin];
}

//// Метод поиска сортировкой
double sort(double a[], int n){
    std::sort(a, a+n);
    return a[0];
}
#endif //PRAC_METHODS_H
