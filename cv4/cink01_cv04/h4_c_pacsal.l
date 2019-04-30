%{
/* Remove comments from C code.  */
#include <stdio.h>
%}

%s COMMENT
%s C1
%s C2

%%

<INITIAL>"{"	BEGIN COMMENT; 
<INITIAL>"}"	{	printf("Kommentař začíná koncem\n");
					yyterminate();
                } 
<INITIAL>.	ECHO;
<INITIAL>"\n" 	ECHO;
<INITIAL> "\(*" BEGIN C1;
<INITIAL> "//" BEGIN C2;
     
<COMMENT>"}"	BEGIN INITIAL;
<COMMENT>.	;
<COMMENT>"\n" 	;
<COMMENT>"{"	{ 
			printf("Comments inside a comment not accepted!\n");
			yyterminate(); 
			}

<C1>. 	;
<C1>"{" ;
<C1>\n ;
<C1>"*\)" BEGIN INITIAL;


<C2>. ;
<C2>\n BEGIN INITIAL;


%%

int main()
{
	yylex();
	return 0;
}
