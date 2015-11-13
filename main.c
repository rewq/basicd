#include <stdio.h>
#include "bison.h"
#include "flex.h"
#include "ast.h"

int main(int argc, char **argv) {
	node* rootnode = NULL;

	char test[]="2+2+2";
  	yyparse(rootnode);
}
