%{
#include <math.h>
double vbltable[26];
%}

%union { ??? }

%token INCREMENT DECREMENT SQRT LOG PRINT
%token <???> VARIABLE
%token <???> NUMBER
%type <???> expression

%left '-' '+'
%left '*' '/'
%nonassoc UMINUS

%%

statement_list:	statement ';' '\n' 
	| statement_list statement ';' '\n'
	| error '\n' { printf("Error in a statement!\n"); }
	; 

statement:	VARIABLE '=' expression { ??? }
	|	PRINT expression { ??? }
	|	VARIABLE INCREMENT { ??? }
	|	VARIABLE DECREMENT { ??? }
	;

expression:	expression '+' expression { $$ = $1+$3; }
	|	expression '-' expression { $$ = $1-$3; }
	|	expression '*' expression { $$ = $1*$3; }
	|	expression '/' expression 
		{ 
			if ($3 == 0.0) 
			{ ??? } 
			else $$ = $1/$3; 
		}
	|	'-' expression %prec UMINUS { $$ = -$2; }
	|	'(' expression ')' { $$ = $2; }
	|	SQRT '(' expression ')' { ??? }
	|	LOG '(' expression ')' { ??? }
 	|	NUMBER
	|	VARIABLE { ??? }
	;
%%

yyerror (char *s)
{
  fprintf (stderr, "%s\n", s);
}

main ()
{
  int i;
  yydebug=0;  /* Setting 1 turns on debugging */ 

  for (i=0; i<26; i++) vbltable[i]=0.0; /* Initializing the table to zero */

  if(!yyparse ())
    printf("OK\n");
}


