#ifndef CLAB10_FUNC_H
#define CLAB10_FUNC_H
#include "stack.h"
#include <cstdio>

//// Initialization of new stack by clearing and assigning null
void InitNewStack(stack** aStack)
{
	if (!aStack) destroy(aStack);
	(*aStack) = nullptr;
}

//// Assigning data from keyboard to stack elements
void InKeyboard(stack** aStack, int n)
{
	InitNewStack(aStack);       // Stack initialization
	int data;       // integer of data for elements
	// Entering of data in cycle until the end of elements
    for (int i = 0; i < n; i++) {
        scanf("%d", &data);
        fflush(stdin);
        push(aStack, data);
    }
	n == 0 ? printf("Empty stack was created\n") :
	printf("Stack was created with %d elements\n", n);
}

//// View stack
void StackShow(stack** aStack)
{
	stack* tmp = (*aStack);     // Creating temporary stack
	if (!tmp) printf("Empty stack\n");
	while (tmp)
	{
		printf("%d\n", tmp -> data);
		tmp = tmp -> next;
	}
	printf("\n");
	free(tmp);
}

//// DO the task
stack* Task(stack *fStack, stack* sStack)
{
	stack *tStack;      // Create the result stack
	InitNewStack(&tStack);      // Initialize the result stack
	// Putting elements from stacks 1 and 2 to the result stack in cycle
        while (fStack && sStack)
        {
            TopToTop(&sStack, &tStack);
            TopToTop(&fStack, &tStack);
        }
	return tStack;
}

//// Clearing memory
void End(stack** fStack, stack** sStack, stack** tStack)
{
	destroy(fStack);
	destroy(sStack);
	destroy(tStack);
}
#endif //CLAB10_FUNCTION_H