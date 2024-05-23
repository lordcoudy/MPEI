//
// Created by savva on 11/04/2020.
//
#include <cstdlib>
#include <cstring>
#include <cstdio>
#include <conio.h>
#include <cctype>
#include <windows.h>

#ifndef CLAB7_FUNC_H
#define CLAB7_FUNC_H


//----------функция повышения регистра---------------------------------
char *ANSIUpperCase(char *s, char *S){                                  
    S = strcpy(S, s);                                                   //функция замены значения S значением s
    char *ch=S;                                                         //указатель s
    while (*ch) {                                                       
        if (*ch>='a' && *ch<='z') *ch= *ch-32;                          //условие замены нижнего регистра верхним путем вычитания 32 знаков
        ch++;
    }
    return S;
}


struct Exam {                                                           //запись про экзамен
    char room[6];                                                       //отвечает за номер кабинета
    char group[9];                                                      //отвечает за номер группы
    struct {                                                            //запись времени
        int hour;                                                       //отвечает за час
        int minute;                                                     //отвечает за минуту
    }time;
    struct {                                                            //запись даты
        int day;                                                        //отвечает за день
        int month;                                                      //отвечает за месяц
        int year;                                                       //отвечает за год
    }date;
    char subject[11];                                                   //отвечает за предмет
    char teacher[21];                                                   //отвечает за фамилию препода
};
//----------создание бинарного файла-----------------------------------
void CreateBinaryFile(char* in, char* out){
    FILE* inp  = fopen(in,"r");                                         //открытие текстового файла на чтение
    FILE* outp = fopen(out,"wb");                                       //открытие бинарного файла на запись
    int count = 0;                                                      //счетчик записей
    while (true)                                                        //условие выполнения цикла
    {
        Exam newExam;                                                   //переменная записи
        char buffer[5];                                                 //создание буферной переменной
        fscanf(inp, "%8s", newExam.group);                              //считывание из файла номера группы
        fscanf(inp, "%s", buffer); newExam.date.day = atoi(buffer);     //считывание дня из файла
        fscanf(inp, "%s", buffer); newExam.date.month = atoi(buffer);   //считывание месяца из файла
        fscanf(inp, "%s", buffer); newExam.date.year = atoi(buffer);    //считывание года из файла
        fscanf(inp, "%s", buffer); newExam.time.hour = atoi(buffer);    //считывание часа из файла
        fscanf(inp, "%s", buffer); newExam.time.minute = atoi(buffer);  //считывание минуты из файла
        fscanf(inp, "%5s", newExam.room);                               //считывание номера кабинета из файла
        fscanf(inp, "%20s", newExam.subject);                           //считывание предмета из файла
        fscanf(inp, "%21s", newExam.teacher);                           //считывание фамилии препода из файла
        if (feof(inp)) break;                    //условие выхода из цикла, в случае конца текстового файла
        fwrite(&newExam, sizeof(Exam),1,outp);                          //запись в бинарный файл записи
        count++;                                                        //счетчик + 1
    }
    fclose(inp);                                                        //закрытие текстового файла
    fclose(outp);                                                       //закрытия бинарного файла
    if (count==0) printf("Created empty file\n");                       //если счетчик равен нулю, то вывести
    else printf("Created file with %d records\n",count);                //иначе вывести
    printf("-------------------------------\nPress any key to continue");
    fgetc(stdin);                                                       //считыание строки и помещение ее в буфер
    fflush(stdin);                                                      //очистка буфера 
}

//----------просмотр бинарного файла-----------------------------------
void ViewBinary(char* file)
{
    FILE* binF = fopen(file,"rb");                                      //открытие бинарного файла на чтение
    int count=0;                                                        //счетчик = 0
    while (true)                                                        //условие цикла
    {
        Exam newExam;                                                   //переменная записи
        fread(&newExam, sizeof(newExam),1,binF);                        //чтение одного блока записей из файла
        if (feof(binF)) break;                                          //условие выхода при конце файла
        printf("Group%8s:\n  Date:%d.%d.%d\n  Time:%d:%d\n Room:%5s\n Subject:%20s\n Teacher:%30s\n",     
               newExam.group, 
               newExam.date.day, newExam.date.month, newExam.date.year, 
               newExam.time.hour, newExam.time.minute, 
               newExam.room, newExam.subject, newExam.teacher);         //вывод записи
        count++;                                                        //счетчик + 1
    }
    fclose(binF);                                                       //закрытие файла
    if (count==0) printf("EmptyFile\n");                                //условие пустого файла
    printf("-------------------------------\nPress any key to continue");
    fgetc(stdin);                                                       //считыание строки и помещение ее в буфер
    fflush(stdin);                                                      //очистка буфера                                        
}

//----------поиск в двоичном файле-------------------------------------
void FindDate(char* bin){
    Exam newExam;                                                       //переменная записи
    FILE *fb = fopen(bin, "rb");                                        //открытие бинарного файла на чтение
    if (fb==NULL) {                                                     //проверка открытия файла
        printf("Error: unable to open binary file%s\n", bin);           //вывод о недоступности файла
        printf("Press ENTER");
        getch();
        return;
    }
    int count=0, nr=1;                                                  //счетчик = 0 и количество блоков = 1
    char st1[21];                                                       //дополнительная переменная для ANSIUpperCase
    char st2[21];                                                       //дополнительная переменная для ANSIUpperCase
    char surname[21];                                                   //переменная фамилии препода
    printf("Enter teacher's surname\n");                                  //вывод запроса
    scanf("%21s", surname);                                             //чтение ввода с клавиатуры
    while (nr){                                                         //цикл пока nr = 1
        nr=fread(&newExam, sizeof(newExam), 1, fb);                     //чтение одного блока записей из файла
        if (nr>0 && strcmp(ANSIUpperCase(newExam.teacher, st1),
        ANSIUpperCase(surname, st2))==0) {                              //проверка того, что nr > 0 and проверка условия поиска - переменная фамилии удовлетворяет существующей фамилии в записи
                count++;                                                //счетчик + 1
                printf("Found %d.%d.%d\n",  
                newExam.date.day,  newExam.date.month, newExam.date.year);  //Вывод даты занятости этого препода
            }
    }
    if (count==0) printf("Data not found\n");                           //если счетчик = 0, то вывод о том, что данные не найдены
    else printf("Found in summary: %d\n", count);                       //иначе вывод общего количества найденных данных
    fclose(fb);                                                         //закрытие бинарного файла
    printf("Press any key to continue");
    getch();
    return;
}
//----------корректировка в двоичном файле-----------------------------
void CorrectFile(char* bin){
    Exam newExam;                                                       //переменная записи
    FILE *fb = fopen(bin, "rb");                                        //открытие бинарного файла на чтение
    if (fb==NULL) {                                                     //проверка открытия файла
        printf("Error: unable to open binary file%s\n", bin);           //вывод о недоступности файла
        printf("Press ENTER");
        getch();
        return;
    }
    int i=-1,count=0;                                                   //переменные счетчик=0, количество считываемых и записываемых блоков = 1, флажок
    do
    {
        bool flag=false;                                                //флажок = ложь
        i++;
        fread(&newExam, sizeof(newExam),1,fb);
        printf("Record has been read:\n");                              //вывод о считывании записи
        printf("Group%8s:\n  Date:%d.%d.%d\n  Time:%d:%d\n Room:%5s\n Subject:%20s\n Teacher:%30s\n",
               newExam.group, 
               newExam.date.day, newExam.date.month, newExam.date.year, 
               newExam.time.hour, newExam.time.minute, 
               newExam.room, newExam.subject, newExam.teacher);         //вывод записи
                                                                
        if (newExam.date.month>12 || newExam.date.month<1) {            //условие проверки: если значение месяца>12 или <1 то присвоить 1
            newExam.date.month=1;
            flag=true;                                                  //флажок = истина
        }
        if((newExam.date.month == 1 ||
        newExam.date.month == 3 ||
        newExam.date.month == 5 ||
        newExam.date.month == 7 ||
        newExam.date.month == 8 ||
        newExam.date.month == 10 ||
        newExam.date.month == 12) &&
        (newExam.date.day>31 || newExam.date.day<1)){  //если месяц = 1,3,5,7,8,10,12, то проверка значения дня: если >31 или <1, то присвоить 1
            newExam.date.day=1;
            flag= true;                                             //флажок = истина
        }
        if((newExam.date.month == 4 ||
        newExam.date.month == 6 ||
        newExam.date.month == 9 ||
        newExam.date.month == 11) &&
        (newExam.date.day>30 || newExam.date.day<1)){  //если месяц = 4,6,9,11, то проверка значения дня: если >30 или <1, то присвоить 1
            newExam.date.day=1;
            flag= true;                                             //флажок = истина
        }
        if((newExam.date.month == 2) &&
        (newExam.date.day>30 || newExam.date.day<1)){  //если месяц = 2, то проверка значения дня: если >28 или <1, то присвоить 1
            newExam.date.day=1;
            flag= true;                                             //флажок = истина
        }
        if (flag) {                                                     //если флажок = истина
            count++;                                                    //счетчик + 1
            printf("Correction has been done:\n");                      //вывод о корректировке
            printf("Group%8s:\n  Date:%d.%d.%d\n  Time:%d:%d\n Room:%5s\n Subject:%20s\n Teacher:%30s\n",
               newExam.group, 
               newExam.date.day, newExam.date.month, newExam.date.year, 
               newExam.time.hour, newExam.time.minute, 
               newExam.room, newExam.subject, newExam.teacher);         //вывод записи
        }
    }while(!feof(fb));                                                  //пока не конец файла
    if (count==0) printf("No need in correction\n");                            //если счетчик = 0, то вывод об отсутствии корректировок
    else printf("Corrections in summary: %d\n", count);                 //иначе вывод общего количества корректировок
    fclose(fb);                                                         //закрытие файла
    printf("Press any key to continue");
    getch();
    return;
}


#endif //CLAB7_FUNC_H


