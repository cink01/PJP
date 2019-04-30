%{
#include <stdio.h>
%}

%%

[a-zA-Z0-9_./]+\.(jpg |tiff |png |fig)	{ printf("%s: je obrázkový soubor\n", yytext); }
[a-zA-Z0-9_./]+\.(rar |tar |tgz|gz)	{ printf("%s: je archivovaný soubor\n", yytext); }
[a-zA-Z0-9_./]+\.(txt |html)	{ printf("%s: je textový soubor\n", yytext); }
[^ \t\n]+		{ printf("%s: tato položka nekončí jednou se zadaných koncovek nebo nemá koncovku\n", yytext); }
\n                      ; /* Do nothing */ 
%%

int main()
{
	yylex();
        return 0;
}
