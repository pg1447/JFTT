%{
#include <iostream>
#include "parser.tab.h"

using namespace std;
#define YY_DECL extern "C" int yylex()
%}

%x COMMENT
%x FAILCOND


%%
[0-9]+		{ yylval=atoi(yytext); return NUMBER; }
"+"		{ return PLUS; }
"-"             { return MINUS; }
"*"             { return MULT; }
"/"             { return DIV; }
"%"		{ return MOD; }
"^"		{ return POW; }
\n		{ return EOL; }
"("		{ return OP; }
")"		{ return CP; }
[[:blank:]]+

^"#"             { BEGIN(COMMENT); }
<COMMENT>\\\n
<COMMENT>\n     { BEGIN(INITIAL); }
<COMMENT>.
	
.		{ BEGIN(FAILCOND); }
<FAILCOND>\n	{ BEGIN(INITIAL); return ERR; }
<FAILCOND>.
	
%%

int yywrap(void){
	return 1;
}
