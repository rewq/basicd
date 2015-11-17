CC=gcc

target:
	bison basicd.bison
	flex basicd.flex
	$(CC) -std=gnu99 -o basicd main.c flex.c bison.c ast.c
clean:
	rm flex.c flex.h bison.c bison.h basicd ast.dot ast.png