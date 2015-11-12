%output  "bison.c"
%defines "bison.h"
%parse-param {int *somevalue}

%code{
#include "flex.h"
	void yyerror (int *somevalue, char const *s){
		fprintf (stderr, "%s\n", s);
	}
}

%union{
  int num;
  char var;
  struct expr* exp;
}

%token <num> NUMBER
%token <num> ADD SUB MUL DIV ABS
%token <num> OPREN CPREN
%token <num> EOL

%type <num> exp factor term

%%

explist: 
| explist exp EOL {printf("= %d\n", $2);printf("%i NUM's added\n",*somevalue); }
;

exp: factor
| exp ADD factor { $$ = $1 + $3; }
| exp SUB factor { $$ = $1 - $3; }
;

factor: term
| factor MUL term { $$ = $1 * $3; }
;

term: NUMBER {*somevalue += 1;}
| ABS term  { $$ = $2 >= 0 ? $2 : -$2; }
| OPREN exp CPREN { $$ = $2; }
;

%%


