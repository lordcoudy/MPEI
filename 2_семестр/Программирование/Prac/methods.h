#ifndef PRAC_METHODS_H
#define PRAC_METHODS_H

#include <algorithm>

//// Простой поиск поэлементно
double simp(double a[], int &n)
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


//// Метод поиска сортировкой
double sort(double a[], int n){
    std::sort(a, a+n);
    return a[0];
}
#endif //PRAC_METHODS_H
