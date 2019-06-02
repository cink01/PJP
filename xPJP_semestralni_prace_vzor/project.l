%{
#include "project.tab.h"
#include "project.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

 
int symcount = 0; 
int lineno=1;

%}
%option yylineno

%x C_COMMENT

%%
 
[ \t\r]         ;
\n              ;


"while"   return WHILE_TOK;
"if"      return IF_TOK;
"else"    return ELSE_TOK;
"return"  return RETURN_TOK;

"int"     { yylval.type = 0; return TYP; }
"float"   { yylval.type = 1; return TYP; }


"<"    { yylval.assig = strdup(yytext); return ASSIG_TOK; }
">"    { yylval.assig = strdup(yytext); return ASSIG_TOK; }
"<="   { yylval.assig = strdup(yytext); return ASSIG_TOK; }
">="   { yylval.assig = strdup(yytext); return ASSIG_TOK; }
"=="   { yylval.assig = strdup(yytext); return ASSIG_TOK; }
"!="   { yylval.assig = strdup(yytext); return ASSIG_TOK; }

[a-zA-Z][a-zA-Z0-9]*  { yylval.type = symlook(yytext); return (IDENTIFIKATOR_TOK);}
[0-9]+                { yylval.type = symlook(yytext); return (NUMBER_TOK);      }


"//"[^\n]*          ;
"/*"                { BEGIN(C_COMMENT); }
<C_COMMENT>"*/"     { BEGIN(INITIAL); }
<C_COMMENT>\n       { ;}
<C_COMMENT>.        { ;}

 
.         return yytext[0];

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
    strncpy(symtable[symcount], symbol, 8);
   // printf("DATA %s -- %d\n", symbol, symcount+1);
    return symcount++;
  }
}
