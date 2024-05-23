#include<iostream>
#include <ctime>
#include "methods.h"

int main(int argc, char* argv[])        // Аргумент - выходной текстовый файл
{
    ////----Объявление переменных----
    FILE* outp = fopen(argv[1],"w");        // Открытие текстового файла на запись
    time_t tstart, tend;        // Переменные начала и окончания счета времени
    double seconds;     // Переменная значения времени
    int n;      // Переменная длины массива (количества элементов)
    double min;     // Переменная минимального элемента
    //-------------------------------------------
    printf("Enter number of elements\n");       // Запрос на ввод n
    scanf("%d", &n);        // Считывание n с клавиатуры
    printf("\n");       //  Снос строки
    double *array = new double [n];     // Объявление массива из n элементов типа double
    srand(time(0)); // инициализация генерации случайных чисел
    //-------------------------------------------
    //// Ввод массива
    char ent;
    printf("\nPress \n"          //вывод вариантов для диалога
                    "\'M\' to enter array manually\n"    // Ввод массива вручную с клавиатуры
                    "\'A\' to enter array automatically\n"       // Ввод массива автоматически
    );
    fflush(stdin);      // Очистка буфера
    ent=(char)getc(stdin);       // Считывание переменной и помещение её в буфер
    fflush(stdin);      // Очистка буфера
    ent =(char)tolower(ent);      // Понижение регистра переменной
    switch(ent)      // Варианты выбора
    {
        //// Ввод массива вручную с клавиатуры
        case 'm':
            printf("Enter array\n");
            for (int i = 0; i < n; i++) {
                printf("Enter a[%d]:", i + 1);
                scanf("%lf", &array[i]);
            }
            for (int i = 0; i < n; i++)
                fprintf(outp, "%lf  ", array[i]);
            fclose(outp);       // Закрытие текстового файла
            break;
            //// Ввод массива автоматически
        case 'a':
            for (int i = 0; i < n; i++)
                array[i] = rand() / (float) RAND_MAX;
            for (int i = 0; i < n; i++) {
                fprintf(outp, "%lf  ", array[i]);
            }
            fclose(outp);       // Закрытие текстового файла
            break;
        default:
            printf("Unknown command\n");
            break;
    }
    //-----------------------------------------------------
    ////Основная часть программы
    bool end=false;     //флажок окончания цикла
    while (!end)        //пока флажок - ложь: цикл
    {
        printf("\nPress \n"          //вывод вариантов для диалога
               "\'S\' to use simple method\n"       // Метод поэлементной проверки
               "\'I\' to use index method\n"        // Метод проверки с запоминанием индекса
               "\'T\' to use sort method\n"     // Метод поиска сортировкой
               "\'B\' to use bigger method\n"       // Экспериментальный метод сравнения
               "\'E\' to exit\n");      // Комманда выхода
        char ch;        // Переменная ответа
        fflush(stdin);      // Очистка буфера
        ch=(char)getc(stdin);       // Считывание переменной и помещение её в буфер
        fflush(stdin);      // Очистка буфера
        ch =(char)tolower(ch);      // Понижение регистра переменной
        switch (ch)
        {
            //// Метод поэлементной проверки
            case 's':
                time(&tstart);
                min = simp(array, n);
                std::cout<< "Simple method: " << min << std::endl;
                time(&tend);
                seconds = difftime(tend, tstart);       // Втроенная функция расчета времени
                printf("The simple time: %f seconds\n", seconds);
                break;
            //// Метод проверки с запоминанием индекса
            case 'i':
                time(&tstart);
                min = index(array, n);
                std::cout<< "Index method: " << min << std::endl;
                time(&tend);
                seconds = difftime(tend, tstart);
                printf("The index time: %f seconds\n", seconds);
                break;
            //// Метод поиска сортировкой
            case 't':
                time(&tstart);
                min = sort(array, n);
                std::cout<< "Sort method: " << min << std::endl;
                time(&tend);
                seconds = difftime(tend, tstart);
                printf("The sort time: %f seconds\n", seconds);
                break;
            //// Экспериментальный метод сравнения
            case 'b':
                time(&tstart);
                min = bigger(array, n);
                std::cout<< "bigger method: " << min << std::endl;
                time(&tend);
                seconds = difftime(tend, tstart);
                printf("The bigger time: %f seconds\n", seconds);
                break;
            //// Комманда выхода
            case 'e':
                end=true;                               //флажок - истина
                break;
            //// Действие по умолчанию
            default:
                printf("Unknown command\n");
                break;
        }
        printf("-------------------------------\n");
    }
    return 0;
}