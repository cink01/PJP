%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include "sp.h"

//pomocné proměnné oznčené podle možností
int t = 0;//základní trasování
int v = 0;//úplné trasování
int d = 0;//syntaktická analýza
int h = 0;//nápověda

char taccodes[][5]={"MOV", "JZ", "ADD", "AND", "HALT"};
int quadcount = 0; // Number of quadruples
int tempcount = 0; // Number of temporary variables 
int labelcount = 0; // Number of labels 
void yyerror (char *mesg);//funkce na výpis chybové zprávy

%}

%token PROGRAM STREDNIK TECKA token_BEGIN token_END token_IF token_THEN token_ASSIGN token_AND
%token ID NUM 
%left '+'

%%

PROG: PROGRAM ID STREDNIK BLOCK TECKA {
        if(t==1){
          printf("Reducing by rule #01\n");
          }
          if(v==1){
            printf("Reducing by rule #01, line #%i \t(PROGRAM)\n", pocetradku);
          }
          makequad(HALT,-1,-1,-1);
        }
     ;

BLOCK:	token_BEGIN LIST token_END {
        if(t==1){
          printf("Reducing by rule #02\n");
          }
          if(v==1){
            printf("Reducing by rule #02, line #%i \t(BEGIN statement_list END)\n", pocetradku);
          }
        }
     ;

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

STMT:  BLOCK {
        if(t==1){
          printf("Reducing by rule #05\n");
          }
          if(v==1){
            printf("Reducing by rule #05, line #%i \t(BLOCK)\n", pocetradku);
          }
        }
    | token_IF EXPR token_THEN STMT {
        if(t==1){
          printf("Reducing by rule #06\n");
          }
          if(v==1){
            printf("Reducing by rule #06, line #%i \t(IF expression THEN statement)\n", pocetradku);
          }
        makequad(JZ, $2,-1,$4);
      }
    | ID token_ASSIGN EXPR {
        if(t==1){
          printf("Reducing by rule #07\n");
          }
          if(v==1){
            printf("Reducing by rule #07, line #%i \t(ASSIGNMENT)\n", pocetradku);
          }
        makequad(MOV, $3, -1, $1);
      }
    | error{d=1;}
    ;
    

EXPR: EXPR '+' EXPR {
        $$=gettemp(); 
        if(t==1){
        	printf("Reducing by rule #08\n");
        }
        if(v==1){
        	printf("Reducing by rule #08, line #%i \t(PLUS)\n", pocetradku);
        }
        makequad(ADD, $1, $3, $$); 
     }
     | EXPR token_AND EXPR {
        $$=gettemp(); 
        if(t==1){
          printf("Reducing by rule #09\n");
          }
          if(v==1){
            printf("Reducing by rule #09, line #%i \t(AND)\n", pocetradku);
          }
        makequad(AND, $1, $3, $$); 
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

int main(char argc, char** argv)
{
  Param(argc,argv);
  if(h==1||d==1)return 0;

  yydebug = 0;
  yyparse(); /* Parse a statement */
  list_quads(); /* Print generated code */
  list_table(); /* Print symbol table */
  return 0;
}

void Param(char argc, char** argv)
{
    if(argc >= 2)
    {
      if(!strcmp(argv[1], "-t"))
        t = 1;
      else if(!strcmp(argv[1], "-v"))
        v = 1;
      else if(!strcmp(argv[1], "-d"))
      {
          if(d==1)
            printf("Chyba syntaxe!");
          else
            printf("Syntaxe v pořádku");
      }
      else if(!strcmp(argv[1], "-h"))
      {
      	h=1;//nastavení proměnné pro -h => ukončení programu po zobrazení nápovědy
        printf("\n\t*******Nápověda programu na překlad jazyka do mezikódu(čtveřic)*******\n\n");
        printf("Pro spusteni zadejte jedním ze stylu:\n ./sp (jedna z možností) < (soubor)\n ./sp (jedna z možností) a po povrzení[ENTER] zadat daný kód a potvrdit stiknutim [CTRL+D]\n");
        printf("Možnosti:\n");
        printf("-t\tZákladná trasování: Vypíše pouze sekvenčně řazený seznam aktuálně aplikovaných pravidel.(Reducing by rule #1)\n");
        printf("-v\tÚplné trasování - Rozšiřuje možnosti volby –t o výpis čísla aktuálního řádku a úplnou textovou reprezentaci použitého pravidla (Reducing by rule #10, line #8 (NAME))\n");
        printf("-d\tSyntaktická analýza: Provede se pouze syntaktická analýza. (Syntax OK)\n");
        printf("-h\tNápověda: Vypíše tuto nápovědu. \n\n\n ");
      }
  }
}

/* Supporting Functions */

void yyerror(char *mesg)
{
  printf("%s\n", mesg);
}

/* Assembles quadruple */
void makequad(tac_operace op, int op1, int op2, int res)
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
  strcpy (tabZnaku[pocetsymbolu], str); /* Add to the symbol table */
  return pocetsymbolu++;
}

/* Gets new label */
int getlabel(void)
{
  char str[6];
  snprintf(str, 5, "_L%i", labelcount++); // Assemble its name 
  str[5] = '\0'; //Adding the end of the string -mark 
  strcpy (tabZnaku[pocetsymbolu], str); // Add to the symbol table 
  return pocetsymbolu++;
}

// Lists intermediate code as quadruples & TAC 
void list_quads(void)
{
  int i;
  int j=0;
  printf ("\nIntermediate code:\n");
  printf ("Quadruples\t\t TAC\n");
  for ( i = 0; i < quadcount; i++){ /* List quadruple & interpret it */
    printf ("%i: (%s, %2d, %2d, %2d)\t ",j, taccodes[quad[i].op], quad[i].o1, quad[i].o2, quad[i].o3);
   
    //snaha o prohození pozic JZ a MOV
    if(taccodes[quad[i].op]=="MOV" && taccodes[quad[i+1].op]=="JZ")
    {
      printf ("%i: (%s, %s, NULL, %s)\n",j,taccodes[quad[i+1].op], tabZnaku[quad[i+1].o1], tabZnaku[quad[i+1].o3]);
      printf ("%i: (%s, %s, NULL, %s)\n",j,taccodes[quad[i].op], tabZnaku[quad[i].o1], tabZnaku[quad[i].o3]);
      i=i+2;
      return;
    }

    switch (quad[i].op)
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

/* Lists symbol table contents */
void list_table (void) 
{
  int i;
  printf("\nSymbol table:\n"); 
  for (i = 0; i < pocetsymbolu; i++)
    printf ("%2d: %s\n", i, tabZnaku[i]); 
  printf ("\n");
}
