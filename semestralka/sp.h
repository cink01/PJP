#ifndef _SP_H
#define _SP_H      

typedef enum 
{
MOV,
JZ,
ADD,
AND,
HALT,
} tac_operace;

/* Function Prototypes */

void yyerror(char *);
int yylex(void);
void makequad(tac_operace, int, int, int);
int gettemp(void);
int getlabel(void);
void list_quads(void);
void list_table(void);
int symlook(char *);

/* Definitions */

char tabZnaku[64][9]; /* Symbol table */
extern int pocetsymbolu; /* Number of symbols in symbol table */
extern int quadcount; /* Number of quadruples*/
extern int tempcount; /* Number of temporary variables */
extern int labelcount; /* Number of labels */
extern int pocetradku;

#define MAXQUADS 32 /* Size of quad array */

struct {   /* Array of quadruples */
  int op; /* Operator */
  int o1;  /* 1st operand */
  int o2;  /* 2nd operand */
  int o3;  /* Result */
} quad[MAXQUADS];

#endif
