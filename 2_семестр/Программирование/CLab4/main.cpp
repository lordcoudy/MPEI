#include <cmath>
#include <clocale>
#include <cstdio>

double mult(const double a[], int left, int right)
{
    bool center = (right - left) / 2;
        return
        left == right ? (pow(a[left],2)+cos(a[left])) :
        left <= center ?
        ((pow(a[left],2)+cos(a[left]))*mult(a, left, left+center)) :
        left > center ?
        ((pow(a[left],2)+cos(a[left]))*mult(a, left+center +1, right)) : 1;
}

int main(int argc, char *argv[]) {
    FILE *fout=fopen(argv[1], "wt");    // Открытие файла
    int N;      // Длина массива (количество элементов)
    setlocale(LC_ALL, "RUS");       // Установка русской локализации
    printf("Enter N\n");        // Запрос на ввод длины массива
    scanf("%d",&N);     // Считывание длины массива
    fflush(stdin);      // Очистка буфера после ввода N
    double *B = new double[N];  // Выделение памяти под массив В
    for (int i=0;i<N;i++)       // Цикл считывания элементов массива
    {
        printf("Enter B[%d]= ", i+1);
        scanf("%lf",&B[i]);
    }
    fflush(stdin);      // Очистка буфера после ввода массива
    if(N != 0)
    {
        printf("Answer is %lf\n", mult(B, 0, N));        // Вывод ответа на экран
        fprintf(fout,"Answer is %lf", mult(B, 0, N));        // Запись ответа в текстовый файл
    } else
        printf("Empty array!\n");
    delete [] B;        // Очистка массива
    fclose(fout);       // Закрытие файла
    printf("Press ENTER");
    getc(stdin);
    return 0;
}