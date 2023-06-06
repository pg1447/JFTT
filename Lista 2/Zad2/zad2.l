%{
#include <stdio.h>
#include <stdlib.h>

int yywrap(void);
int yylex(void);
void yyerror(const char *s);
int NL = 1;
%}

%x COM_STAR
%x COM_BASL
%x STRING

%%

\"			ECHO;BEGIN(STRING);
\<\!\-\-		BEGIN(COM_STAR);
\-\-			BEGIN(COM_BASL);

<COM_STAR>[^*\n]
<COM_STAR>\-\-+[^>]	
<COM_STAR>\n		NL++;
<COM_STAR>\-\-\>	BEGIN(INITIAL);

<COM_BASL>[^\\\n]
<COM_BASL>\\+\n		NL++;
<COM_BASL>\n		printf("\n");BEGIN(INITIAL);NL++;

<STRING>\"		ECHO;BEGIN(INITIAL);
<STRING>\n		ECHO;BEGIN(INITIAL);NL++;
%%

int yywrap(void)
{
	return 1;
}

void yyerror(const char *msg)
{
	printf("error: %s\nBlad w lini: %d\n", msg, NL);
	exit(0);
}

int main(void)
{
	yylex();
	
	return 1;
}
