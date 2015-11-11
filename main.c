#include <stdio.h>
#include "bison.h"
#include "flex.h"

int main(int argc, char **argv) {
	int somevalue = 0;
	int value;
  	value = yyparse((int*)&somevalue);
}
