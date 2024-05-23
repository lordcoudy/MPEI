#include "func.h"
#include <cctype>
int main()
{
	stack *afStack, *asStack, *atStack; // Stacks (first, second, third)
	InitNewStack(&afStack);	// Stacks initialization
	InitNewStack(&asStack);
	InitNewStack(&atStack);
	bool end = false;	// if true = stop
	while(!end)
	{
		printf("Choose what to do:\n"
			"\'N\' - enter stack from keyboard\n"
			"\'T\' - do the task\n"
            "\'V\' - view answer\n"
			"\'E\' - exit\n");
		char choice;		// Letter of choice
		scanf("%c", &choice);       // Scan input for choice
		fflush(stdin);      // Clearing buffer
		int n;      // Number of elements in stack
		choice = (char)tolower(choice);     // Lowing letters
		switch(choice)
		{
			case 'n':
				printf("Enter number of elements in stack:\n");
				scanf("%d", &n);        // Scan input for number of elements
                printf("Enter the first stack:\n");
				InKeyboard(&afStack, n);        // Run function of creating stack 1 from keyboard
                printf("Enter the second stack:\n");
                InKeyboard(&asStack, n);        // Run function of creating stack 2 from keyboard
				break;
			case 'v':
				printf("The task result:\n");
				StackShow(&atStack);        // Run function of viewing stack
				break;
			case 't':
				atStack = Task(afStack, asStack);       // Assigning result of task function to answer stack
				break;
			case 'e':
				end = true;
				break;
			default:
				printf("Unknown command\n");
				break;
		}
		printf("----------------------------------------\n");
	}
	End(&afStack, &asStack, &atStack);		// Clearing memory
	return 0;
}