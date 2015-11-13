#include <stdio.h>
#include "bison.h"
#include "flex.h"
#include "ast.h"

int main(int argc, char **argv) {

	node* rootnode = NULL;
  	yyparse(&rootnode);

  	print_ast(rootnode);
}
