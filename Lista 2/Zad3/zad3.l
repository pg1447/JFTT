%{
#include <stdio.h>
#include <stdlib.h>

int yywrap(void);
int yylex(void);
void yyerror(const char *s);
int NL = 1;
int isDoc =0; // włączanie odpowiedniej opcji 0 lub 1
%}

%x COM_STAR
%x COM_BASL
%x COM_DOC_STAR
%x COM_DOC_BASL
%x STRING

%%

\"			    ECHO;BEGIN(STRING);
\/\*\*			if(isDoc) {BEGIN(COM_DOC_STAR);} else { ECHO; }
\/\*			BEGIN(COM_STAR);
\/\/\/			if(isDoc) {BEGIN(COM_DOC_BASL);} else { ECHO; }
\/\/			BEGIN(COM_BASL);

<COM_STAR>[^*\n]	/* zjedz wszystko co nie jest NL albo "*" */
<COM_STAR>\*+[^/]	/* zjedz gwiazdki po ktorych nie ma "/" */
<COM_STAR>\n		NL++;
<COM_STAR>\*+\/		BEGIN(INITIAL);

<COM_DOC_STAR>[^*\n]	/* zjedz wszystko co nie jest NL albo "*" */
<COM_DOC_STAR>\*+[^/]	/* zjedz gwiazdki po ktorych nie ma "/" */
<COM_DOC_STAR>\n		NL++;
<COM_DOC_STAR>\*+\/		BEGIN(INITIAL);


<COM_DOC_BASL>[^\\\n]	/* zjedz wszystko oprocz "\" oraz entera */
<COM_DOC_BASL>\\+\n		NL++;
<COM_DOC_BASL>\n		ECHO;BEGIN(INITIAL);NL++;


<COM_BASL>[^\\\n]	/* zjedz wszystko oprocz "\" oraz entera */
<COM_BASL>\\+\n		NL++;
<COM_BASL>\n		ECHO;BEGIN(INITIAL);NL++;

<STRING>\"		ECHO;BEGIN(INITIAL);
<STRING>\n		ECHO;NL++;

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
