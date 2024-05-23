//
// Created by Lord Coudy on 27/05/2020.
//

#ifndef TR_LISTMAKE_H
#define TR_LISTMAKE_H

#include <cstdio>

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

//// Structure info: element info and pointer to the next one
struct TElem
{
    TInfo data;
    TElem* next;
};

//// Queue element
struct TMake
{
   TElem* start;
   TElem* end;
};

//// FUNCTION OF CHECKING QUEUE FOR EMPTYNESS
bool isEmpty(TMake make)
{
    return (make.start == nullptr) && (make.end == nullptr);
}

//// FUNCTION OF QUEUE ELEMENT INITIALIZING
void Initialize(TMake &make)
{
    make.start = make.end = nullptr;
}

//// FUNCTION OF PUSHING STRUCTURE ELEMENT TO THE END OF QUEUE
void AddToLast(TMake &make, TInfo info)
{
    TElem* e = new TElem;
    if(!isEmpty(make))
    {
        e->data = info;
        make.end->next = e;
        make.end = e;
        make.end->next = nullptr;
    } else
    {
        e->data = info;
        make.start = e;
        make.end = e;
        make.end->next = nullptr;
    }
}

//// FUNCTION OF TAKING QUEUE ELEMENT FROM ITS START
TInfo PullFromStart(TMake &make)
{
    TInfo info = make.start->data;
    if (make.start == make.end)
    {
        Initialize(make);
        return info;
    } else
    {
        TElem* elem = make.start->next;
        delete make.start;
        make.start = elem;
        return info;
    }
}

//// FUNCTION OF PRINTING QUEUE IN LOG FILE
void Out(TMake make)
{
    FILE *f;
    f = fopen("log.txt", "a");
    TElem* e = new TElem;
    e = make.start;
    while (e != nullptr)
    {
        fprintf(f, "Group: %8s\nDate: %d.%d.%d\nTime: %d:%d\nRoom: %5s\nSubject: %10s\nTeacher: %20s\n",
                e->data.group,
                e->data.date.day, e->data.date.month, e->data.date.year,
                e->data.time.hour, e->data.time.minute,
                e->data.room, e->data.subject, e->data.teacher);
        e = e->next;
    }
    fprintf(f, "\n\n");
    fclose(f);
}
#endif //TR_LISTMAKE_H
