%{
/* Remove comments from C code.  */
#include <stdio.h>
%}

%s COMMENT

%%

<INITIAL>"/*"		BEGIN COMMENT; 
<INITIAL>"*/"		{	printf("Kommentař začíná koncem\n");
				       	yyterminate();
                    } 
<INITIAL>"."	ECHO;
<INITIAL>"\n" 	ECHO;
     
<COMMENT>"*/"		BEGIN INITIAL;
<COMMENT>"."		;
<COMMENT>"\n" 		;
<COMMENT>"/*"		{ 
			printf("Comments inside a comment not accepted!\n");
			yyterminate(); 
			}

%%

int main()
{
	yylex();
	return 0;
}
