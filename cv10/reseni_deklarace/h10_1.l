%{
#include <string.h>
#include "h10_1.tab.h"	/* definitions from YACC */
#define YY_NO_UNPUT
#define YY_NO_INPUT

int lineno=1;

%}

%%
int			yylval.type = 0; return TYPE;
float			yylval.type = 1; return TYPE;
char			yylval.type = 2; return TYPE;
[_a-zA-Z][_a-zA-Z0-9]* 	{
			yylval.name = strdup(yytext);
			return ID;
			}

[ \t]			;
\n			lineno++;
.			return yytext[0];
%%
