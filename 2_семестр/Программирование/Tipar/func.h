//
// Created by Lord Coudy on 27/05/2020.
//

#ifndef TR_FUNC_H
#define TR_FUNC_H

#include <cstdlib>
#include <cstring>
#include "listMake.h"

//// FUNCTION OF CASE INCREASE
char *ANSIUpperCase(char *s, char *S)
{
    S = strcpy(S, s);       // Copy full string from input to output
    char *ch = S;       // Creating pointer to S
    //// Cycle of case increase
    while (*ch)
    {
        if (*ch>='a' && *ch<='z')
            *ch = *ch - 32;
        ch++;
    }
    return S;
}

//// FUNCTION OF CORRECTION INFO
void Correction(TInfo &info)
{
    //// If month is not between 1 to 12
    if (info.date.month > 12 || info.date.month < 1)
        info.date.month = 1;
    //// If day value is less than 1
    if (info.date.day < 1)
        info.date.day = 1;
    //// If day value of certain month is bigger than 28, 30 or 31
    switch (info.date.month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
             if (info.date.day > 31)
                 info.date.day = 31;
        case 2:
            if (info.date.day > 28)
                info.date.day = 28;
        case 4:
        case 6:
        case 9:
        case 11:
            if (info.date.day > 30)
                info.date.day = 30;
    }
}

//// FUNCTION OF READING INFO FROM KEYBOARD
void InKeyboard(TMake &make)
{
    TInfo info = {"", "",0,0,0,0,0,"",""};
    char buf[5];        // Buffer char for keeping int data in string format
    printf("Enter room: ");
    scanf("%5s", info.room);
    printf("Enter group: ");
    scanf("%8s", info.group);
    printf("Enter hour: ");
    scanf("%s", buf); info.time.hour = atoi(buf);
    printf("Enter minutes: ");
    scanf("%s", buf); info.time.minute = atoi(buf);
    printf("Enter day:");
    scanf("%s", buf); info.date.day = atoi(buf);
    printf("Enter month: ");
    scanf("%s", buf); info.date.month = atoi(buf);
    printf("Enter year: ");
    scanf("%s", buf); info.date.year = atoi(buf);
    printf("Enter subject: ");
    scanf("%10s", info.subject);
    printf("Enter teacher's surname: ");
    scanf("%20s", info.teacher);

    Correction(info);
    AddToLast(make, info);
    Out(make);
}

//// FUNCTION OF CLEARING QUEUE
void Free(TMake &make)
{
    while (!isEmpty(make))
    {
        PullFromStart(make);        // Taking info from start of queue
    }
}

//// FUNCTION OF DELETING CERTAIN NUMBER OF ELEMENTS
void Delete(int n, TMake &make)
{
    int i = 0;
    while ((!isEmpty(make)) && (i < n))
    {
        PullFromStart(make);        // Taking info from start of queue
        i++;
    }
    Out(make);
}

//// FUNCTION OF DOING TASK
void Search(char surname[21], TMake &make)
{
    TInfo info;     // Queue element
    TMake buffer;   // Queue buffer
    char st1[21], st2[21];      // Additional strings
    Initialize(buffer);     // Initializing of buffer queue
    while (!isEmpty(make))
    {
        info = PullFromStart(make);     // Taking info from start of queue
        //// Checking if needed surname is in queue
        if (strcmp(ANSIUpperCase(info.teacher, st1), ANSIUpperCase(surname, st2)) == 0)
            AddToLast(buffer, info);    // Put found info to buffer
    }
    while (!isEmpty(buffer))
    {
        AddToLast(make, PullFromStart(buffer));
    }
    Out(make);      // Writing found info to log file
}

//// FUNCTION OF READING INFO FROM FILE
void InFile(char* fName, TMake &make)
{
    FILE* f = fopen(fName, "rt");       // Open file in reading mode
    while (true)
    {
        TInfo info = {"", "",0,0,0,0,0,"",""};
        char buf[5];
        if (feof(f)) break;
        fscanf(f, "%5s", info.room);
        fscanf(f, "%8s", info.group);
        fscanf(f, "%s", buf); info.time.hour = atoi(buf);
        fscanf(f, "%s", buf); info.time.minute = atoi(buf);
        fscanf(f, "%s", buf); info.date.day = atoi(buf);
        fscanf(f, "%s", buf); info.date.month = atoi(buf);
        fscanf(f, "%s", buf); info.date.year = atoi(buf);
        fscanf(f, "%10s", info.subject);
        fscanf(f, "%20s", info.teacher);
        Correction(info);
        AddToLast(make, info);
    }
    fclose(f);
    Out(make);
}
#endif //TR_FUNC_H
