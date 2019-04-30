%{
#include <stdio.h>
%}

%%

 /* ignore white space */

 /* string yytext contains text that matched RE */
 /* RE and action are separated by whitespace */
 
[^ \t\n]+	{ printf("%s: don't recognize this file\n", yytext); }
[\t ]+			; /* ignore white space */

[a-zA-Z0-9_./]+\.jpg |
[a-zA-Z0-9_./]+\.tiff |
[a-zA-Z0-9_./]+\.png |
[a-zA-Z0-9_./]+\.fig	{ printf("%s: is a picture file\n", yytext); }
doplnit pro dalsi




[^ \t\n]+		{ printf("%s: isn't a file with ending\n", yytext); }

\n                      ; /* Do nothing */ 
%%

int main()
{
	yylex();
        return 0;
}
