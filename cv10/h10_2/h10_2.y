%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "h10_2.h"

char taccodes[][8]={"TAC_ADD", "TAC_SUB", "TAC_MUL", "TAC_DIV", "TAC_ASS", "TAC_PRI", "TAC_LBL", "TAC_JMP", "TAC_JZ"};
int quadcount = 0; /* Number of quadruples*/
int tempcount = 0; /* Number of temporary variables */
int labelcount = 0; /* Number of labels */
%}

%token VAR NUM ASSIGN PRINT REPEAT
%left '-' '+'
%left '*' '/'

%%

/* = = = = = Grammar Section = = = = = = = = = = = = */

/* Productions */ 		/* Semantic actions */

stmts:	stmts stmt
     |	stmt
     ;

stmt:	VAR ASSIGN expr ';'	{  makequad(TAC_ASS, $3, -1, $1); }
     |	PRINT expr ';'	  { makequad(TAC_PRI, $2, -1, -1);}
     |	repeat
     |	error ';'
     ;

expr :	expr '+' expr   {$$=gettemp(); makequad(TAC_ADD, $1, $3, $$); }
     |	expr '-' expr 	{ $$=gettemp(); makequad(TAC_SUB, $1, $3, $$);}
     |	expr '*' expr 	{$$=gettemp(); makequad(TAC_MUL, $1, $3, $$); }
     |	expr '/' expr 	{ $$=gettemp(); makequad(TAC_DIV, $1, $3, $$); }
     |	'(' expr ')' 	  { $$=gettemp(); makequad(TAC_ASS, $2, -1, $$); }
     |	term 			
     ;

term :	NUM | VAR
     ;

repeat:	REPEAT VAR	{
		/* Storing start label index into repeat symbol, which
		   don't have any other useful value - because of loops
		   inside loops we cannot use global variables to store
		   labels, we would need a stack. End label is naturally
		   startlabel + 1, because it's created after startlabel */
		$1 = getlabel(); /* Start label */
		getlabel(); /* End label */
		makequad(TAC_LBL, $1, -1, -1);
		makequad(TAC_JZ, $2, $1+1, -1);
		} 
	'{' stmts '}'	{
		makequad(TAC_JMP, $1, -1, -1);
		makequad(TAC_LBL, $1+1, -1, -1);
		}
     ;

%%

int main()
{
  yydebug = 0;
  yyparse(); /* Parse a statement */
  list_quads(); /* Print generated code */
  list_table(); /* Print symbol table */
  return 0;
}

/* Supporting Functions */

void yyerror(char *mesg)
{
  printf("%s\n", mesg);
}

/* Assembles quadruple */
void makequad(tac_operation op, int op1, int op2, int res)
{
  quad[quadcount].op = op; /* Operator */
  quad[quadcount].o1 = op1; /* Operands */
  quad[quadcount].o2 = op2;
  quad[quadcount].o3 = res; /* Result */
  quadcount++;
}

/* Gets new temporary */
int gettemp(void)
{
  char str[6];
  snprintf(str, 5, "_T%i", tempcount++); /* Assemble its name */
  str[5] = '\0'; /* Adding the end of the string -mark */
  strcpy (symtable[symcount], str); /* Add to the symbol table */
  return symcount++;
}

/* Gets new label */
int getlabel(void)
{
  char str[6];
  snprintf(str, 5, "_L%i", labelcount++); /* Assemble its name */
  str[5] = '\0'; /* Adding the end of the string -mark */
  strcpy (symtable[symcount], str); /* Add to the symbol table */
  return symcount++;
}

/* Lists intermediate code as quadruples & TAC */
void list_quads(void)
{
  int i;
  printf ("\nIntermediate code:\n");
  printf ("Quadruples\t\t TAC\n");
  for ( i = 0; i < quadcount; i++){ /* List quadruple & interpret it */
    printf ("(%s, %2d, %2d, %2d)\t ", taccodes[quad[i].op], quad[i].o1, quad[i].o2, quad[i].o3);
    switch (quad[i].op)
    {
      case TAC_ADD:
 	printf ("%s := %s + %s\n", symtable[quad[i].o3], symtable[quad[i].o1], symtable[quad[i].o2]);
	break;
      case TAC_SUB:
 	printf ("%s := %s - %s\n", symtable[quad[i].o3], symtable[quad[i].o1], symtable[quad[i].o2]);
	break;
      case TAC_MUL:
 	printf ("%s := %s * %s\n", symtable[quad[i].o3], symtable[quad[i].o1], symtable[quad[i].o2]);
	break;
      case TAC_DIV:
 	printf ("%s := %s / %s\n", symtable[quad[i].o3], symtable[quad[i].o1], symtable[quad[i].o2]);
	break;
      case TAC_ASS:
	printf("%s := %s\n", symtable[quad[i].o3], symtable[quad[i].o1]);
	break;
      case TAC_PRI:
        printf("print %s\n", symtable[quad[i].o1]);
	break;
      case TAC_LBL:
        printf("label %s\n", symtable[quad[i].o1]);
	break;
      case TAC_JMP:
        printf("jump to %s\n", symtable[quad[i].o1]);
	break;
      case TAC_JZ:
        printf("if %s is zero, jump to %s\n", symtable[quad[i].o1], symtable[quad[i].o2]);
	break;
      default:
	printf("Not a valid TAC code!\n");
    }
  }
}

/* Lists symbol table contents */
void list_table (void) 
{
  int i;
  printf("\nSymbol table:\n"); 
  for (i = 0; i < symcount; i++)
    printf ("%2d: %s\n", i, symtable[i]); 
  printf ("\n");
}
