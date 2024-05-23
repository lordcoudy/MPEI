#include <cstdio>
#include "func.h"
#include <cctype>
//------------------------------------------------------------

//------------------главная функция-----------------------
int main(int argc, char* argv[]){
    bool end=false;                                     //флажок окончания цикла
    while (!end)                                        //пока флажок - ложь: цикл
    {
        printf("Choose what you want to do:\n"          //вывод вариантов для диалога
               "\'N\' to create new binary file\n"
               "\'V\' to view content of binary file\n"
               "\'F\' to find element by key\n"
               "\'C\' to correct elements\n"
               "\'X\' to exit\n");
        char ch;                                        //переменная ответа
        ch=(char)getc(stdin);                           //считывание переменной и помещение её в буфер
        fflush(stdin);                                  //очистка буфера
        ch =(char)tolower(ch);                          //аналог uppercase
        switch(ch)                                      //аналог case of делфи
        {
            case 'n':
                CreateBinaryFile(argv[1], argv[2]);     //функция создания бинарного файла
                break;
            case 'v':
                ViewBinary(argv[2]);                    //функция просмотра бинарного файла
                break;
            case 'f':
                FindDate(argv[2]);                      //функция поиска даты
                break;
            case 'c':
                CorrectFile(argv[2]);                   //функция корректировки
                break;
            case 'x':
                end=true;                               //флажок - истина
                break;
            default:
                printf("Unknown command\n");
                break;
        }
        printf("-------------------------------\n");
    }
    return 0;
}
//-----------------------------------------------------------