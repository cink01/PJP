%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "sp.h"

/*pomocné proměnné oznčené podle možností*/
int t = 0;/*základní trasování*/
int v = 0;/*úplné trasování*/
int d = 2;/*syntaktická analýza*/
int h = 0;/*nápověda*/
int pomocna = 0;

char taccodes[][5]={"MOV", "JZ", "ADD", "AND", "HALT"};/*TAC*/
int quadcount = 0; /* Pocet cveric */
int tempcount = 0; /* Number of temporary variables */
int labelcount = 0; /* Number of labels */
void yyerror (char *mesg);/* funkce na výpis chybové zprávy*/

%}

/*inicializace tokenu*/
%token PROGRAM STREDNIK TECKA token_BEGIN token_END token_IF token_THEN token_ASSIGN token_AND token_ADD
%token ID NUM 

%%
/*PROGRAM*/
PROG: PROGRAM ID STREDNIK BLOCK TECKA { 
        makequad(HALT,-1,-1,-1);/*vytvoření čtveřice HALT*/
        
        if(t==1){
          printf("Reducing by rule #01\n");
          }
          if(v==1){
            printf("Reducing by rule #01, line #%i \t(PROGRAM)\n", pocetradku);
          }
        }
     ;
/*BLOCK*/
BLOCK:	token_BEGIN LIST token_END {
        if(t==1){
          printf("Reducing by rule #02\n");
          }
          if(v==1){
            printf("Reducing by rule #02, line #%i \t(BEGIN statement_list END)\n", pocetradku);
          }
        }
     ;
/*LIST*/
LIST:  STMT {
        if(t==1){
          printf("Reducing by rule #03\n");
          }
          if(v==1){
            printf("Reducing by rule #03, line #%i \t(STATEMENT)\n", pocetradku);
          }
        }
    | STMT STREDNIK LIST {
        if(t==1){
          printf("Reducing by rule #04\n");
          }
          if(v==1){
            printf("Reducing by rule #04, line #%i \t(STATEMENT_LIST)\n", pocetradku);
          }
        }
    ;
/*STATEMENT*/
STMT: BLOCK {
        if(t==1){
          printf("Reducing by rule #05\n");
          }
          if(v==1){
            printf("Reducing by rule #05, line #%i \t(BLOCK)\n", pocetradku);
          }
        }
    | token_IF EXPR token_THEN STMT { 
        makequad(JZ, $2,-1,$$);/*vytvoření čtveřice JZ*/

        if(t==1){
          printf("Reducing by rule #06\n");
          }
          if(v==1){
            printf("Reducing by rule #06, line #%i \t(IF expression THEN statement)\n", pocetradku);
          }
      }
    | ID token_ASSIGN EXPR { 
        makequad(MOV, $3, -1, $1);/*vytvoření čtveřice MOV*/

        if(t==1){
          printf("Reducing by rule #07\n");
          }
          if(v==1){
            printf("Reducing by rule #07, line #%i \t(ASSIGNMENT)\n", pocetradku);
          }
      }
    | error{
        if(d) 
        {
          d = 1;
        }
      }
    ;
    
/*EXPRESSION*/
EXPR: EXPR token_ADD EXPR { 
        $$=gettemp(); 
        makequad(ADD, $1, $3, $$);/*vytvoření čtveřice ADD */

        if(t==1){
        	printf("Reducing by rule #08\n");
        }
        if(v==1){
        	printf("Reducing by rule #08, line #%i \t(PLUS)\n", pocetradku);
        }
      }
      | EXPR token_AND EXPR {
        $$=gettemp(); 
        makequad(AND, $1, $3, $$); /*vytvoření čtveřice AND*/

        if(t==1){
          printf("Reducing by rule #09\n");
          }
          if(v==1){
            printf("Reducing by rule #09, line #%i \t(AND)\n", pocetradku);
          }
      }
      | ID {
        if(t==1){
          printf("Reducing by rule #10\n");
          }
          if(v==1){
            printf("Reducing by rule #10, line #%i \t(NAME)\n", pocetradku);
          }
      }
      | NUM{
        if(t==1){
          printf("Reducing by rule #11\n");
          }
          if(v==1){
            printf("Reducing by rule #11, line #%i \t(INTEGER)\n", pocetradku);
          }
      }
      ;

%%

void Param(char argc, char** argv)/*FUNKCE NA ZVOLENI PARAMETRU*/
{
    if(argc >= 2)/*když je zadán parametr*/
    {
      if(!strcmp(argv[1], "-t"))
        t = 1;
      else if(!strcmp(argv[1], "-v"))
        v = 1;
      else if(!strcmp(argv[1], "-d"))
      {
        pomocna = 1;
      }
      else if(!strcmp(argv[1], "-h"))
      {
        h=1;/*nastavení proměnné pro -h => ukončení programu po zobrazení nápovědy*/
        printf("\n\t*************Nápověda programu na překlad jazyka do mezikódu(čtveřic)*************\n\n");
        printf("\t  Prace vytvorena jako semestralni prace studentem Tomasem Cinkem v predmetu PJP \n\n");
        printf("Pro spusteni zadejte jedním ze stylu:\n ./sp (jedna z možností) < (soubor)\n ./sp (jedna z možností) a po povrzení[ENTER] zadat daný kód a potvrdit stiknutim [CTRL+D]\n");
        printf("Možnosti:\n");
        printf("-t\tZákladná trasování: Vypíše pouze sekvenčně řazený seznam aktuálně aplikovaných pravidel.(Reducing by rule #1)\n");
        printf("-v\tÚplné trasování - Rozšiřuje možnosti volby –t o výpis čísla aktuálního řádku a úplnou textovou reprezentaci použitého pravidla (Reducing by rule #10, line #8 (NAME))\n");
        printf("-d\tSyntaktická analýza: Provede se pouze syntaktická analýza. (Syntax OK)\n");
        printf("-h\tNápověda: Vypíše tuto nápovědu. \n\n\t**********************************************************************************\n ");
      }
  }
}

int main(char argc, char** argv)
{
  Param(argc,argv);
  
  if(h==1)return 0;
  yyparse(); /* Parse a statement */

  if(d == 2) 
    printf("\nSyntax OK\n"); 
  else if (d == 1)
    printf("\nSyntaxe spatne\n"); 

  if(pomocna!=1)
  {
   /* yydebug = 0; */
    list_quads(); /* Vypsani mezikodu */
    list_table(); /* Vypsani tabulky symbolu */
  }

  return 0;
}

/* Supporting Functions */
void yyerror(char *mesg)
{
  d=1;
  printf("%s\n na radku: %i\n", mesg, pocetradku);
}

/* Assembles quadruple */
void makequad(tac_operace op, int op1, int op2, int res)
{
  quad[quadcount].op = op; /* Operator */
  quad[quadcount].o1 = op1; /* Operand */
  quad[quadcount].o2 = op2; /* Operand */ 
  quad[quadcount].o3 = res; /* Result */
  quadcount++;
}

/* Gets new temporary */
int gettemp(void)
{
  char str[6];
  snprintf(str, 5, "_T%i", tempcount++); /* Assemble its name */
  str[5] = '\0'; /* Adding the end of the string -mark */
  strcpy (tabZnaku[pocetsymbolu], str); /* Add to the symbol table */
  return pocetsymbolu++;
}

/* Gets new label */
int getlabel(void)
{
  char str[6];
  snprintf(str, 5, "_L%i", labelcount++); /* Assemble its name */
  str[5] = '\0'; /*Adding the end of the string -mark */
  strcpy (tabZnaku[pocetsymbolu], str); /* Add to the symbol table */
  return pocetsymbolu++;
}

/* Vypis mezikodu cvteric */ 
void list_quads(void)
{
  int i;
  int j=0;
  printf ("\nMezikod:\n");
  printf ("Ctverice pozice:\tCtverice symboly\n");
  for ( i = 0; i < quadcount; i++){ /* Vypis ctveric s pozicemi */
    printf ("%i: (%s, %2d, %2d, %2d)\t ",j, taccodes[quad[i].op], quad[i].o1, quad[i].o2, quad[i].o3);
    switch (quad[i].op) /* Vypis ctveric se symboly */
    {
      case MOV:
 	printf ("%i: (%s, %s, NULL, %s)\n",j,taccodes[quad[i].op], tabZnaku[quad[i].o1], tabZnaku[quad[i].o3]);
	break;
      case JZ:
        printf("%i: (JZ, %s, NULL, %s)\n",j, tabZnaku[quad[i].o1], tabZnaku[quad[i].o3]);
	break;

      case ADD:
 	printf ("%i: (ADD, %s ,%s, %s)\n",j, tabZnaku[quad[i].o1], tabZnaku[quad[i].o2], tabZnaku[quad[i].o3]);
	break;
      case AND:
 	printf ("%i: (%s, %s, %s, %s)\n",j,taccodes[quad[i].op], tabZnaku[quad[i].o1], tabZnaku[quad[i].o2], tabZnaku[quad[i].o3]);
	break;

      case HALT:
	printf("%i: (HALT, NULL, NULL, NULL)",j);
	break;
      default:
	printf("%i: Not a valid TAC code!\n",j);
    }j++;
  }
}

/* Vypis tabulky symbolu */
void list_table (void) 
{
  int i;
  printf("\nTabulka symbolu:\n"); 
  for (i = 0; i < pocetsymbolu; i++)
    printf ("%2d: %s\n", i, tabZnaku[i]); 
  printf ("\n");
}
