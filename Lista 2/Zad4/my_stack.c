#include "my_stack.h"
#include <stdio.h>
#include <stdlib.h>

void pop(struct stack* st, int x){
	struct elem* new_elem = malloc(sizeof(struct elem));
	new_elem->value = x;
	new_elem->next = st->top;
	st->top = new_elem;
}

int push(struct stack* st){
	if(st->top == NULL)
		return EMPTY;
	int ret_value = st->top->value;
	struct elem* new_top = st->top->next;
	free(st->top);
	st->top = new_top;
	return ret_value;
}

int count(struct stack* st, char c){
        int a,b;
        if((b=push(st))==EMPTY || (a=push(st))==EMPTY){
		handleError(st, "za mała liczba argumentów");
		return 0;
	}
        switch(c){
                case '+':
                        pop(st, a+b);
                        break;
                case '-':
                        pop(st, a-b);
                        break;
                case '*':
                        pop(st, a*b);
                        break;
                case '/':
                        pop(st, a/b);
                        break;
                case '%':
                        pop(st, a%b);
                        break;
                case '^':
                        pop(st, my_pow(a,b));
                        break;
        }
        return 1;
}

int isEmpty(struct stack* st){
	if(st->top != NULL) return NOEMPTY;
	return EMPTY;
}

int my_pow(int a, int b){
	int acc = 1;
	for(int i=0 ;  i<b ; i++)
		acc*=a;
	return acc;
}

void cleanStack(struct stack* st){
	while(isEmpty(st) != EMPTY)
        	push(st);
}

void get_result(struct stack* st){
	int result = push(st);
	if(result == EMPTY)
		handleError(st, "brak elementów");
	else if(isEmpty(st) == NOEMPTY)
		handleError(st, "za mała liczba operatorów");
	else
		printf("= %d\n", result);
}

void handleError(struct stack* st, const char* msg){
	printf("Błąd: %s\n", msg);
	cleanStack(st);
}
