%{
#include "h6_2.tab.h"
%}

%%
[0-9]+ { return NUMBER; }

[ \t]	;		/* ignore white space */
\n	return 0;	/* logical EOF */
.	return yytext[0];
%%
