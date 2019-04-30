%{
/* Usually in YACC terminals are written using small letters and nonterminals
using capital letters, but in this case I've made an exception because of the
original exercise definition in exercises 5. Of course that's just a common
way, no rule to be followed. */ 

void yyerror(char *);
int yylex(void);

#define YYDEBUG 1 /* redundant, typically included in makefile */
#include <stdio.h>
%}


%%

S: A B 	{ printf("Correct derivation!\n"); };
A: 'a' 'h' | 'a' 'b' A 'c'| 'a' B 'c';
B: C D E ;
C: 'd' | 'e' ;
D: 'f' D | 'f' ;
E: B | 'g' ;

%%

void yyerror (char *s)
{
  /* fprintf (stderr, "%s\n", s); */
  printf("Incorrect derivation!\n");
}

int main(void)
{
#if YYDEBUG
  yydebug = 1;
#endif
	if(!yyparse())
		printf("End of input reached\n");
	return 0;
}

