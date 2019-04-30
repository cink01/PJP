%{
  /* YACC generates y.tab.h, which includes the tokens, when you use -d  -flag */
#include "h6_1.tab.h"

%}

%s COMMENT

%%

<INITIAL>\;		BEGIN COMMENT; 
<COMMENT>\;		BEGIN INITIAL;
<COMMENT>.		;
<COMMENT>\n 	;

[ \t]	;
[a-Z]* 		return yytext[0];
[0-9]+ { return NUMBER; }
\n		return 0;  /* EOF */
%%
