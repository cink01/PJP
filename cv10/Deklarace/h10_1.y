%{
#include <string.h>
#include <stdlib.h>
#include <stdio.h>
#include "h10.h"
  
int yylex();
void yyerror (char *s);
void addsymb(int, char *);
void symprint();

extern int lineno;
char *types[3]={"int", "float", "char"};
%}

%token <type> TYPE
%token <name> ID

%union {
  int type;
  char *name;
}

%%

program:	declarationlist statementlist
	;

statementlist:	 /* empty */	
	;

/* Definition part */

declarationlist: declarationlist declaration
	|	             declaration
	;


declaration:	TYPE variablelist ';'
	|	          error ';' { ??? }
	;

variablelist:	ID { ??? }
	|	          variablelist ',' ID { ??? }
	;
    /* pozor, pøi dìdìní je tøeba použít syntaxi $<tokentype>0 */

%%

void addsymb(int type, char *s) 
{
  struct symtab *sp;
  
  for(sp = symtab; sp < &symtab[NSYMS]; sp++) 
    {
      /* is it already here? */
      if(sp->name && !strcmp(sp->name, s))
	{
	  fprintf(stderr, "line %i: Error: %s is already defined\n", lineno,s);
	  return;
	}
      if(!sp->name) 
	{
	  sp->name = s;
	  sp->type = type;
	  return ;
	} 
    }
  yyerror("Too many symbols");
  exit(1); /* cannot continue */
}     

void symprint()
{
  struct symtab *sp;
  
  printf("\n** Symbol table **\n");        
  for(sp = symtab; sp < &symtab[NSYMS]; sp++)
    if(sp->name)
      printf("Dcl(\"%s\", \"%s\")\n", sp->name, types[sp->type]);
    else
      return;
}

int main()
{
  yydebug = 0;
  yyparse();
  symprint();
  return 0;
}

void yyerror (char *s) 
{
  fprintf (stderr, "Problems encountered: %s\n", s);
}
