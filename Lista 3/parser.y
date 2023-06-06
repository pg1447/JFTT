%{
#include <cstdio>
#include <iostream>
#include <math.h>
#include <sstream>

using namespace std;

extern "C" int yylex();
extern "C" FILE *yyin;

int modulo(int,int);
int podziel(int a, int b);
void yyerror(const char *s);

int flag = 0;

stringstream ss;
%}

%token NUMBER
%token PLUS MINUS
%token MULT DIV
%token POW
%token EOL
%token OP CP
%token ERR

%left PLUS MINUS
%left MULT DIV MOD
%right POW
%nonassoc UMINUS

%%

start:							{ /*nic*/ }
	|			start exp EOL		{ cout << ss.str() << endl;  if(flag == 0) {cout <<  "Wynik: " << $2 << endl; } ss.str(""); flag = 0; }
	|			start exp ERR		{ yyerror(""); }
	|			start ERR		{ yyerror(""); }
	|			start error EOL
	;

exp:				NUMBER			{ ss << $1 << " "; }
	|			exp PLUS exp		{ $$ = $1 + $3; ss << "+ "; }
	|			exp MINUS exp		{ $$ = $1 - $3; ss << "- "; }
	|			exp MULT exp		{ $$ = $1 * $3; ss << "* "; }
	|			exp DIV exp		{ if($3 == 0){ flag=1; } else{ $$ = podziel($1, $3); } ss << "/ "; }
	|			exp POW	exp		{ $$ = pow($1, $3); ss << "^ "; }
	|			exp MOD exp		{ $$ = modulo($1, $3); ss << "% "; }
	|	{ ss << "-"; }	MINUS exp %prec UMINUS	{ $$ = -$3; }
	|			OP exp CP		{ $$ = $2; }
	;

%%


int main()
{
	yyparse();
}

void yyerror(const char *s){
	cout << "Błąd.\n";
	ss.str("");
}

int podziel(int a, int b){
	return (a-modulo(a,b))/b;
}

int modulo(int liczba, int modulo)
{
	if(modulo == 0){
		flag = 1;
		return -1;
	}
	return (liczba % modulo + modulo) % modulo;
}
