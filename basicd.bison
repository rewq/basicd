%output  "bison.c"
%defines "bison.h"

%code{
#include "flex.h"
	void yyerror (char const *s){
		fprintf (stderr, "%s\n", s);
		yyparse(); // Continue Parsing if there is an error
	}
}

%token NUMBER
%token ADD SUB MUL DIV ABS
%token OPREN CPREN
%token EOL

%%

explist: 
| explist exp EOL {printf("= %d\n", $2);}
;

exp: factor
| exp ADD factor { $$ = $1 + $3; }
| exp SUB factor { $$ = $1 - $3; }
;

factor: term
| factor MUL term { $$ = $1 * $3; }
;

term: NUMBER
| ABS term  { $$ = $2 >= 0 ? $2 : -$2; }
| OPREN exp CPREN { $$ = $2; }
;

%%


