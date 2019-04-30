%{
/**************************************************
 * String literal parser with a simple symbol table
 **************************************************/
#define STR_LENGTH 200
#define STR_AMOUNT 50
#include <string.h>
#include <stdlib.h>

char strings[STR_AMOUNT][STR_LENGTH];
int first_free = 0;
char *str_ptr = NULL;

%}

%x	str

%%
\"		{ 
		if (first_free == STR_AMOUNT )
		  {
			printf("Symbol table is full!\n");
			yyterminate();
		  }
		else
		  {
			str_ptr = strings[first_free];
			BEGIN(str);
		  }
		}

<str>\\\n ;
 
<str>\"		{
		*str_ptr = '\0';
		first_free++;
		BEGIN(INITIAL);
		}

<str>\\\"	{
		*str_ptr++ = yytext[0];
		*str_ptr++ = yytext[1];  
		}

<str>.	{
		*str_ptr++=yytext[0];
		}

<str>\n {
			printf("Error: New line inside of string!");
			yyterminate();
		}
	
.|\n		;

%%

int main()
{
	int i;
	yylex();
	printf("\n ** Content of the symbol table **\n");
	for(i=0; i<first_free; i++)
		printf("%s\n", strings[i]);
	return 0;
}

int yywrap(void)
{
        return 1;
}
