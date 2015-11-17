/* Flex directives */
%option outfile="flex.c" header-file="flex.h"
%option noyywrap nounput noinput

/* This code is copied verbatim to the .c file generated - includes token defs from bison */
%{
#include "bison.h"
%}

/* Grammar */
%%
"+"    {return ADD;}
"*"    {return MUL;}
"-"    {return SUB;}
"("    {return OPREN;}
")"    {return CPREN;}
"{"    {return OBRACK;}
"}"    {return CBRACK;}
[0-9]+ {yylval.num = atoi(yytext); return NUMBER;}
[ \t]  { /* ignore whitespaces */ }
\n     {return 0;}
.      {printf("Mistery character %s\n", yytext);}
%%