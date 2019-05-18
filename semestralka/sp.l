%{
#include <string.h>
#include "sp.tab.h"	/* definitions from YACC */
#include "sp.h"
#define symbol_l 20
#define YY_NO_UNPUT
//pomocné proměnné na počet symbolů a řádků
int pocetsymbolu = 0;       
int pocetradku=1;
%}

%%

//tokeny
"program" return (PROGRAM);
";" return (STREDNIK);
"." return (TECKA);
"begin" return (token_BEGIN);
"end" return (token_END);
"if" return (token_IF);
"then" return (token_THEN);
":=" return (token_ASSIGN);
"and" return (token_AND);
//vrácení čísel a id
[_a-zA-Z][_a-zA-Z0-9]{0,7} yylval = symlook(yytext);return (ID);
[0-9]+ yylval = symlook(yytext);return (NUM);
//ošetření mezer a komentářů
[ \t] ; 
^";".*[\n] ; //ošetření komentáře
\n pocetradku++;//počítání řádků
. return yytext[0];

%%

int symlook(char *symbol)
{
  int i=0;
  while(i<pocetsymbolu && strcmp(symbol, tabZnaku[i]))
    i++;
  if(i<pocetsymbolu)
    return i;
  else
  {
    strncpy(tabZnaku[pocetsymbolu], symbol, 8); 
    return pocetsymbolu++;
  }
}
