#include "ast.h"
#include <stdlib.h>
#include <stdio.h>

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