%{
#include <stdio.h>
%}

%%
 
[ \t\n]         ;
doplnit reg výraz {		printf("%s is according the grammar\n", yytext); 
		}

		/* LEX searches always for the longest matching string */

[a-z0-9]+	{ printf("%s is not according the grammar\n", yytext); }
.		; /* Ignore other characters */

%%

int main(void)
{
        yylex(); 
        return 0;
}

int yywrap(void)
{
	return 1;
}
