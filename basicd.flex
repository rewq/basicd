%option outfile="flex.c" header-file="flex.h"
%option noyywrap nounput noinput

%{
#include "bison.h"
%}

%%
"+"    {return ADD;}
"*"    {return MUL;}
"-"    {return SUB;}
"("    {return OPREN;}
")"    {return CPREN;}
"{"    {return OBRACK;}
"}"    {return CBRACK;}
[0-9]+ {yylval.num = atoi(yytext); return NUMBER;}
\n     {return EOL;}
[ \t]  { /* ignore whitespaces */ }
.      {printf("Mistery character %s\n", yytext);}
%%