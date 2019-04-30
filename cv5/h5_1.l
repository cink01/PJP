%{
#include <stdio.h>
int lineno;
%}

%%
main	printf("tok_main\t\t%d\n", lineno);
int		printf("tok_int\t\t%d\n", lineno);
void	printf("tok_void\t\t%d\n", lineno);

=		printf("tok_equal\t\t%d\n",lineno);
\( 		printf("tok_lparen\t\t%d\n",lineno);
\)		printf("tok_rparen\t\t%d\n",lineno);
\{		printf("tok_lbrace\t\t%d\n",lineno);
\{		printf("tok_rbrace\t\t%d\n",lineno);
*		printf("tok_mult\t\t%d\n",lineno);
\;		printf("tok_semicolon\t\t%d\n",lineno);
return	printf("tok_return\t\t%d\n",lineno);

[a-zA-Z]+	printf("tok_id\t\t%s\t%d\n", yytext, lineno);
[0-9]+	printf("tok_intconst\t\t%s\t%d\n", yytext, lineno);

[ \t]+			;  //preskoci
\n 			lineno++;
/* libovolny znak - vypis nerozpoznano */
.	{
		printf("Unrecognized\t%s\t%d\n", yytext, lineno);
		yyterminate();
		}
%%

int main(void) 
{
 	printf("TOKEN\t\tATTRI\tLINENO\n");
	yylex();
	printf("%d lines tokenized without problems. End of input reached.\n", lineno-1);
	return 0;
}
