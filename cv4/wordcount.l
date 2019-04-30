%{
int charCount = 0, wordCount = 0, lineCount = 0;
%}

word [^ \t\n]+
%%
{word}		{ wordCount++; charCount += yyleng; } /* charCount += strlen(yytext); */
*****nový řádek { pocitej znaky; radky }
*****znak		{ pocitej znaky }
%%

int main(int argc, char **argv)
{
	if ( argc > 1 )
		yyin = fopen( argv[1], "r" );
	else
		yyin = stdin;
	yylex();
	printf("lines: %d words: %d characters: %d\n", lineCount, wordCount, charCount);
	return 0;
}
