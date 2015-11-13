/* Bison Directives */
%output  "bison.c" // Code containing yyparse()
%defines "bison.h" // Header file including token declarations needed by Flex
%parse-param {struct astnode **rootnode} // Adds variables to be passed into yyparse()

/* This section is copied verbatim to the .C file generated */
%code{
#include "flex.h"
#include "ast.h"
/* yyerror() needs the parse-param's defined aswell */
void yyerror (struct astnode **rootnode, char const *s);
}

/* YYLVAL types*/
%union{
  int num;
  char var;
  struct astnode* node;
}


/* Terminal Tokens and Type Declaration */
%token <num> NUMBER 
%token ADD SUB MUL DIV
%token OPREN CPREN CBRACK OBRACK
%token EOL

/* Non Terminal Type Declaration */
%type <node> expr

%left '+' ADD
%left '*' MUL


/* Grammar Section */
%%
input
    : expr { *rootnode = $1;}
    ;
 
expr
    : expr[L] ADD expr[R] { $$ = add_node($L, T_ADD, $R); }
    | expr[L] MUL expr[R] { $$ = add_node($L, T_MUL, $R); }
    | OPREN expr[E] CPREN { $$ = $E; }
    | NUMBER { $$ = add_num($1); }
    ;
%%
/* 	Error handling - this is the default function reccomended by Bison docs */
void yyerror (struct astnode **rootnode, char const *s){ 
	fprintf (stderr, "%s\n", s);
}