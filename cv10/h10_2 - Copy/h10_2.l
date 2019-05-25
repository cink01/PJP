%{
#include <string.h>
#include "h11.tab.h"	/* definitions from YACC */
#include "h11.h"
#define symbol_len 20
#define YY_NO_UNPUT

int symcount = 0;       /* The amount of symbols in the symbol table or the index
                           of the first free place in the symbol table */
int lineno=1;
%}

%%

repeat				return REPEAT;
print				return PRINT;
":="				return ASSIGN;
[_a-zA-Z][_a-zA-Z0-9]{0,7} 	yylval = symlook(yytext); return VAR;
[0-9]+				yylval = symlook(yytext); return NUM;

[ \t]				; /* ignore white space */
\n				lineno++;
.				return yytext[0];

%%

int symlook(char *symbol)
{
  int i=0;

  while(i<symcount && strcmp(symbol, symtable[i]))
    i++;
  if(i<symcount)
    return i;
  else
  {
    strncpy(symtable[symcount], symbol, 8); /* Add to table */
    return symcount++;
  }
}
