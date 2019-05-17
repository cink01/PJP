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

//funkce
void yyerror(char *);
int yylex(void);
void makequad(tac_operace, int, int, int);
int gettemp(void);
int getlabel(void);
void list_quads(void);
void list_table(void);
int symlook(char *);

//proměnné
char tabZnaku[64][9]; //tabulka znaku
extern int pocetsymbolu; //pocet symbolu v tabulce
extern int quadcount; // pocet čtveřic
extern int tempcount; // počet dočasných položek
extern int labelcount; // počet labelu
extern int pocetradku; // pocet radku

#define MAXQUADS 32 //velikost pole čtveřic

//pole čtveřic
struct {   
  int op; //jedna z možností z TAC operací
  int o1;  //operand 1
  int o2;  //operand 2
  int o3;  //výsledek
} quad[MAXQUADS];

#endif