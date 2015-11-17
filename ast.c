#include "ast.h"

node* add_node(node* left, int type, node* right){
  node* n = malloc(sizeof(node));
  n->type = type;
  n->value = 0;
  n->left = left;
  n->right = right;
  return n;
}
node* add_num(int value){
  node* n = malloc(sizeof(node));
  n->type = T_VAL;
  n->value = value;
  n->left = NULL;
  n->right = NULL;

  return n;
}

void print_ast(node* start_node){
	printf("NT: %i\n", start_node->type);
	if (start_node->left > 0){
		puts("left");
		print_ast(start_node->left);
	}
	if (start_node->right > 0){
		puts("right");
		print_ast(start_node->right);
	}
}

void graphviz(node* start_node) {
	FILE *dotfile = fopen("ast.dot", "w");
	fprintf(dotfile, "digraph tree {\n");
	dump_ast(dotfile, start_node, 1);
	fprintf(dotfile, "}\n");
	fclose(dotfile);

	// OS X
  	//system("dot -Tpng ast.dot > ast.png && open ast.png");

  	// Linux
  	system("dot -Tpng ast.dot > ast.png && xdg-open ast.png");
}
void dump_ast(FILE *dotfile, node* start_node, int index){
	switch(start_node->type) {
	  case T_ADD :
	     fprintf(dotfile, "node%i [label=\"+\"];\n", index);
	     break;
	  case T_MUL :
	     fprintf(dotfile, "node%i [label=\"*\"];\n", index);
	     break;
	  case T_VAL :
	     fprintf(dotfile, "node%i [label=\"%i\"];\n", index,start_node->value);
	     break;
	  default :
	     fprintf(dotfile, "node%i;\n", index);
	}
	if (start_node->value > 0){
		fprintf(dotfile, "node%i [label=\"%i\"];\n", index,start_node->value);
	}
	if (start_node->left > 0){	
		fprintf(dotfile, "node%i->node%i;\n", index, 2*index);
		dump_ast(dotfile, start_node->left,2*index);
	}
	if (start_node->right > 0){
		fprintf(dotfile, "node%i->node%i;\n", index, 2*index+1);
		dump_ast(dotfile, start_node->right,2*index+1);
	}
}