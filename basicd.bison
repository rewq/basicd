/* Bison Directives */
%output  "bison.c" // Code containing yyparse()
%defines "bison.h" // Header file including token declarations needed by Flex
%parse-param {struct astnode* rootnode} // Adds variables to be passed into yyparse()

/* This section is copied verbatim to the .C file generated */
%code{
#include "flex.h"
#include "ast.h"
/* yyerror() needs the parse-param's defined aswell */
void yyerror (struct astnode* rootnode, char const *s);

int evaluate(node *e)
{
    switch (e->type) {
        case T_VAL:
            return e->value;
        case T_MUL:
            return evaluate(e->left) * evaluate(e->right);
        case T_ADD:
            return evaluate(e->left) + evaluate(e->right);
        default:
            // shouldn't be here
            return 0;
    }
}
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
    : expr EOL { rootnode = $1;print_ast(rootnode);}
    ;
 
expr
    : expr[L] ADD expr[R] { $$ = add_node($L, T_ADD, $R); }
    | expr[L] MUL expr[R] { $$ = add_node($L, T_MUL, $R); }
    | OPREN expr[E] CPREN { $$ = $E; }
    | NUMBER { $$ = add_num($1); }
    ;
%%
/*
input
    : expr { *expression = $1; }
    ;
 
expr
    : expr[L] TOKEN_PLUS expr[R] { $$ = createOperation( ePLUS, $L, $R ); }
    | expr[L] TOKEN_MULTIPLY expr[R] { $$ = createOperation( eMULTIPLY, $L, $R ); }
    | TOKEN_LPAREN expr[E] TOKEN_RPAREN { $$ = $E; }
    | TOKEN_NUMBER { $$ = createNumber($1); }
    ;*/
/* 	Error handling - this is the default function reccomended by Bison docs */
void yyerror (struct astnode* rootnode, char const *s){ 
	fprintf (stderr, "%s\n", s);
}