#ifndef CLAB10_STACK_H
#define CLAB10_STACK_H
#include <cstdlib>

typedef int TInfo;      // Making an integer type TInfo
struct stack            // Structure stack
{
	TInfo data;         // Data of stack object
	stack* next;        // Pointer to the next object of stack
};

//// Put an element into stack function
void push(stack** aStack, TInfo data)
{
	if (*aStack == nullptr)     // If stack is empty
	{
		stack* newElement = new stack;      // Creating a new element of stack
		newElement -> data = data;      // Assigning fetched data to the new element's data
		newElement -> next = nullptr;       // Setting the connection of element by setting next element as null
		*aStack = newElement;       // Assigning elements to stack
	} else      // If stack is not empty
	{
		stack* newElement = new stack;      // Creating a new element of stack
		newElement -> data = data;      // Assigning fetched data to the new element's data
		newElement -> next = *aStack;       // Setting the connection of element by setting first stack element as next
		*aStack = newElement;       // Assigning elements to stack
	}
}

//// Put an element from one stack to another function
void TopToTop (stack **StackOne, stack **StackAnother){
    stack *Elem, *StTop=*StackOne, *Dop=*StackAnother;      // Creating temporary stacks
    Elem = StTop;
    StTop = StTop->next;
    Elem->next = Dop;
    Dop = Elem;
    // Assigning temporary stack's data to real stacks
    *StackOne = StTop;
    *StackAnother = Dop;
}

//// Destroying last stack element function
void destr_last(stack** aStack)
{
	stack* tmp = (*aStack) -> next;
	free(aStack);       // Clearing current object of stack
	*aStack = tmp;
}

//// Destroing the whole stack using destr_last in cycle function
void destroy(stack** aStack)
{
	while (*aStack)
	{
		destr_last(aStack);
	}
}
#endif //CLAB10_STACK_H