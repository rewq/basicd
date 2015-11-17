#include <stdio.h>
#include "bison.h"
#include "flex.h"
#include "ast.h"

int main(int argc, char **argv) {

	yyin = fopen(argv[1], "r");

	if (yyin == NULL) {
		puts("No source file (.bd) given");
		printf("\n>>> ");
	}
	node* rootnode;
  	yyparse(&rootnode);

  	graphviz(rootnode);
}
