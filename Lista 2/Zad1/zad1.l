%{
#include <stdio.h>

int yywrap(void);
int yylex(void);
int new_line=0;
int ilosc_slow=0;
%}

%%
^[[:blank:]]*\n
^[[:blank:]]+
[[:alnum:]]+				printf("%s", yytext);ilosc_slow++;
[[:blank:]]+$						
[[:blank:]]*				printf(" ");
\n					printf("\n");new_line++;
%%

int yywrap(void)
{
	return 1;
}

int main(void)
{
	yylex();
	printf("Number of lines: %d\nNumer of words: %d\n", new_line, ilosc_slow);
	return 1;
}
