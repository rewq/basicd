#include <stdio.h>
#include "bison.h"
#include "flex.h"
#include "ast.h"

int main(int argc, char **argv) {

	node* rootnode;
  	yyparse(&rootnode);

  	graphviz(rootnode);
}
