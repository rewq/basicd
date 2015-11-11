%option outfile="flex.c" header-file="flex.h"
%option noyywrap nounput noinput

%{
#include "bison.h"
%}

%%
"+"    {return ADD;}
"-"    {return SUB;}
[0-9]+ {yylval = atoi(yytext); return NUMBER;}
\n     {return EOL;}
[ \t]  { /* ignore whitespaces */ }
.      {printf("Mistery character %s\n", yytext);}
%%