#include <iostream>
#include "func.h"

int main()
{
    TMake make;     // Queue
    char choice;        // Char of choice
    int n = 0;      // Integer for elements deleting
    Initialize(make);       // Initializing new queue
    bool end = true;        // Boolean for cycle
    //// Dialog cycle
    while (end)
    {
        printf("\nChoose:"
               "\nC - to clear list"
               "\nF - to read elements from file"
               "\nK - to add elements from keyboard"
               "\nT - to do task"
               "\nD - to delete n elements"
               "\nE - to exit\n");
        fflush(stdin);      // Clear buffer
        choice = (char)getc(stdin);     // Read choice from keyboard
        fflush(stdin);      // Clear buffer
        choice = (char)tolower(choice);     // Lowing choice letter
        switch (choice)
        {
            //// Function of clearing queue
            case 'c':
                Free(make);
                break;
            //// Function of reading info from file
            case 'f':
                InFile("in.txt", make);
                break;
            //// Function of reading info from keyboard
            case 'k':
                InKeyboard(make);
                break;
            //// Function of doing task
            case 't':
                char surname[21];
                printf("Enter teacher's surname:\n");
                scanf("%21s", surname);
                Search(surname, make);
                break;
            //// Function of deleting certain number of elements
            case 'd':
                printf("Enter n:\n");
                scanf("%d", &n);
                if (n<1) n=1;
                Delete(n, make);
                break;
            //// Exit command
            case 'e':
                end = false;
                break;
            //// Default
            default:
                printf("Unknown command\n");
                break;
        }
        printf("-------------------------------------------\n");
    }
    return 0;
}
