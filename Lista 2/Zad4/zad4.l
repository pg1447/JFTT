%{
#include "my_stack.h"
#include <stdio.h>
#include <stdlib.h>


int yywrap(void);
int yylex(void);
struct stack* st;
%}

%x FAILCOND

%%
-?[0-9]+                pop(st, atoi(yytext));
[\+\-\*\/\%\^]          if(count(st, yytext[0])==0)BEGIN(FAILCOND);
\n		                get_result(st);
[[:blank:]]+
.		printf("Błąd: zły symbol: \"%s\"\n", yytext); cleanStack(st); BEGIN(FAILCOND);

<FAILCOND>.*\n	BEGIN(INITIAL);
%%

int yywrap(void)
{
	return 1;
}

int main(void)
{
	st = malloc(sizeof(struct stack));
	yylex();
	free(st);
	return 1;
}
