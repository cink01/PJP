#ifndef _project_H
#define _project_H      
 

/* Function Prototypes */

int gettemp(void);
int getlabel(void);
int symlook(char *);


 extern void yyerror (char *s);
 extern int yylex();
/* Definitions */

char symtable[64][9]; /* Symbol table */

extern int symcount; /* Number of symbols in symbol table */
extern int adresscount; /* Number of quadruples*/
extern int tempcount; /* Number of temporary variables */
extern int labelcount; /* Number of labels */
extern int lineno;
 

 typedef enum 
{
TAC_ADD,
TAC_SUB,
TAC_MUL,
TAC_DIV,
TAC_ASS,
TAC_EXP,
TAC_LBL,
TAC_GOTO,
TAC_IF
} tac_operation;


#define MAXQUADS 100 /* Size of quad array */

struct {   				/* Array of quadruples */
  tac_operation typeCommand;	/* Type of operation */
  int operand_res; 				/* Operator kam ukladam */
  int perand1;  				/* 1st operand */
  char * s_operator ;  			/* operator action */
  int operand2;  				/* 2nd operand */
} codes[MAXQUADS];

#endif

 
