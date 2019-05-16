%{
#include "h7.tab.h"
%}

%%
[ \t]	;		/* ignore white space */

[0-9]+ 	{ ??? = atof(yytext); return NUMBER; }
[a-z]	{ ??? = yytext[0]-'a'; printf("%c", (yytext[0]-'a'));return VARIABLE; }
"++"	return INCREMENT;
"--"	return DECREMENT;
sqrt	return SQRT;
log	return LOG;
print	return PRINT;
"\n"    return yytext[0];
.	return yytext[0];
%%
