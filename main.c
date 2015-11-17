#include <stdio.h>
#include "bison.h"
#include "flex.h"
#include "ast.h"

int main(int argc, char **argv) {

	yyin = fopen(argv[1], "r");
	
	node* rootnode;
  	yyparse(&rootnode);

  	graphviz(rootnode);
}
