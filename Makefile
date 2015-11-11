target:
	bison basicd.bison
	flex basicd.flex
	$(CC) -Wall -std=gnu99 -o basicd main.c flex.c bison.c
clean:
	rm flex.c flex.h bison.c bison.h basicd