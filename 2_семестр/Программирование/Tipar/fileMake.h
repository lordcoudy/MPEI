//
// Created by Lord Coudy on 27/05/2020.
//

#ifndef TR_FILEMAKE_H
#define TR_FILEMAKE_H

#include <cstdio>
#include <ctime>
#include <cstdlib>
#include <cstring>

const int multiplier = 2;       //Special constant for checking

//// Structure element
struct TInfo
{
    char room[6];
    char group[9];
    struct
    {
        int hour;
        int minute;
    } time;
    struct
    {
        int day;
        int month;
        int year;
    } date;
    char subject[11];
    char teacher[21];
};
//// Queue element
struct TMake
{
    char fName[31];
    int start;
    int end;
    FILE *f;
};

//// FUNCTION OF CHECKING QUEUE FOR EMPTYNESS
bool isEmpty(TMake make)
{
    if (make.end < make.start)
        return true;
    else
        return false;
}

//// FUNCTION OF QUEUE ELEMENT INITIALIZING
void Initialize(TMake &make)
{
    srand(time(NULL));
    for (int i = 0; i < 31; i++)
    {
        make.fName[i] = '\0';
    }
    ////Creating random name
    for (int i = 0; i < 10; i++)
    {
        make.fName[i] = (char)(rand() % 26 + 65);
    }
    strcat(make.fName, ".bin");
    make.f = fopen(make.fName, "w+b");
    make.start = 0;
    make.end = make.start - sizeof(TInfo);
    fclose(make.f);
}

//// FUNCTION OF PUSHING STRUCTURE ELEMENT TO THE END OF QUEUE
void AddToLast(TMake &make, TInfo info)
{
    make.f = fopen(make.fName, "r+b");
    make.end += sizeof(TInfo);
    fseek(make.f, make.end, SEEK_SET);
    fwrite(&info, sizeof(TInfo), 1, make.f);
    fclose(make.f);
}

//// FUNCTION OF TAKING QUEUE ELEMENT FROM ITS START
TInfo PullFromStart(TMake &make)
{
    if(!isEmpty(make))
    {
        TInfo buffer;
        make.f = fopen(make.fName, "r+b");
        fseek(make.f, make.start, SEEK_SET);
        fread(&buffer, sizeof(TInfo), 1, make.f);
        make.start += sizeof(TInfo);

        if (make.start >= multiplier * sizeof(TInfo))
        {
            TInfo temp;
            for (int i = make.start; i < make.end; i += sizeof(TInfo))
            {
                fseek(make.f, i, SEEK_SET);
                fread(&temp, sizeof(TInfo), 1, make.f);
                fseek(make.f, 0 - (multiplier + 1) * sizeof(TInfo), SEEK_CUR);
                fwrite(&temp, sizeof(TInfo), 1, make.f);
            }
            make.end = make.end - make.start;
            make.start = 0;
        }
        fclose(make.f);
        return buffer;
    }


}

//// FUNCTION OF PRINTING QUEUE IN LOG FILE
void Out(TMake make)
{
    FILE* f = fopen("log.txt", "at");
    make.f = fopen(make.fName, "r+b");
    fseek(make.f, make.start, SEEK_SET);
    for (int i = make.start; i <= make.end; i+=sizeof(TInfo))
    {
        TInfo info;
        fread(&info, sizeof(TInfo), 1, make.f);
        fprintf(f, "Group: %8s\nDate: %d.%d.%d\nTime: %d:%d\nRoom: %5s\nSubject: %10s\nTeacher: %20s\n",
                info.group,
                info.date.day, info.date.month, info.date.year,
                info.time.hour, info.time.minute,
                info.room, info.subject, info.teacher);
        fprintf(f, "\n\n");
    }
    fclose(make.f);
    fclose(f);
}
#endif //TR_FILEMAKE_H
