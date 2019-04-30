#ifndef _H11_H
#define _H11_H      

typedef enum 
{
TAC_ADD,
TAC_SUB,
TAC_MUL,
TAC_DIV,
TAC_ASS,
TAC_PRI,
TAC_LBL,
TAC_JMP,
TAC_JZ
} tac_operation;

/* Function Prototypes */

void yyerror(char *);
int yylex(void);
void makequad(tac_operation, int, int, int);
int gettemp(void);
int getlabel(void);
void list_quads(void);
void list_table(void);
int symlook(char *);

/* Definitions */

char symtable[64][9]; /* Symbol table */
extern int symcount; /* Number of symbols in symbol table */
extern int quadcount; /* Number of quadruples*/
extern int tempcount; /* Number of temporary variables */
extern int labelcount; /* Number of labels */
extern int lineno;

#define MAXQUADS 32 /* Size of quad array */

struct {   /* Array of quadruples */
  int op; /* Operator */
  int o1;  /* 1st operand */
  int o2;  /* 2nd operand */
  int o3;  /* Result */
} quad[MAXQUADS];

#endif
