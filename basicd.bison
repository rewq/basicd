/* Bison Directives */
%output  "bison.c" // Code containing yyparse()
%defines "bison.h" // Header file including token declarations needed by Flex
%parse-param {int *somevalue} // Adds variables to be passed into yyparse()

/* This section is copied verbatim to the s.c file generated */
%code{

#include "flex.h"
#include "ast.h"
/* yyerror() needs the parse-param's defined aswell */
void yyerror (int *somevalue, char const *s){ 
	fprintf (stderr, "%s\n", s);
}

}

/* YYLVAL types*/
%union{
  int num;
  char var;
  struct expr* exp;
}

/* Terminal Tokens and Type Declaration */
%token <num> NUMBER ADD SUB MUL DIV ABS
%token <num> OPREN CPREN CBRACK OBRACK
%token <num> EOL

/* Non Terminal Type Declaration */
%type <num> exp factor term


/* Grammar Section */
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


