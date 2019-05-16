%{
#include "h6_2.tab.h"
%}

%%
[0-9]+ { yylval.num = strtol(yytext, NULL, 10); return NUMBER; }
[a-Z]+ { yylval.id = new std::string(yytext);return ID;}

[ \t]	;		/* ignore white space */
\n	return 0;	/* logical EOF */
.	return yytext[0];
%%
