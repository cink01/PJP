%{
/* Define some variables here */
%}


%%

	/* Rules here */

%%

int main(int argc, char **argv)
{
        if ( argc > 1 )
              ;  /* add code */
        else
              ;  /* add code */
        yylex();
        printf("lines: %d words: %d characters: %d\n", lineCount, wordCount, charCount);
        return 0;
}
