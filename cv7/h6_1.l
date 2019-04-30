%{
  /* YACC generates y.tab.h, which includes the tokens, when you use -d  -flag */
#include "h6_1.tab.h"

%}

%%
[a-h] 		return yytext[0];
\n		return 0;  /* EOF */
%%
