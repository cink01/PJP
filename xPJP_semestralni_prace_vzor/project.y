%{
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "project.h"

int tempcount = 1;
int labelcount = 1;

%}


%union {
  int type;
  char *assig;
}

%token TYP IF_TOK WHILE_TOK ELSE_TOK RETURN_TOK
%token <type> IDENTIFIKATOR_TOK
%token <type> NUMBER_TOK
%token <assig> ASSIG_TOK

%left '-' '+'
%left '*' '/'
%nonassoc UNARY

%nonassoc ELSE_TOK

%%

PROGRAM:	
	|  PROGRAM  FUNCTION
	|	
	; 		
	
FUNCTION:
	TYP IDENTIFIKATOR_TOK '(' ARGUMENTY ')' '{' DEFINICE '}' 
													{
														while(tempcount > 1 ) tempcount--;	//Konec funkce mazu temp promenne
													}	
	 | 	;
	
ARGUMENTY:
	TYP IDENTIFIKATOR_TOK ARGUMENTY 
	| ',' ARGUMENTY 
	|	
	;    				

DEFINICE:
	IFCOMMAND  DEFINICE	 
	| WHILECOMMAND DEFINICE 
	| PRIRAZENI DEFINICE 
	| RETURN  
	| 	
	;    				
	
IFCOMMAND:
	IF_TOK '(' RELACE ')'
		{ 
			int label = getlabel();
			$<type>1 = label;
			printf("if not %s goto %s\n", symtable[$<type>3], symtable[label]);
			while(tempcount > 1 ) tempcount--;
		}
	'{' DEFINICE '}' 
		{
			int label = getlabel();
			$<type>2 = label;
			printf ("goto %s\n", symtable[label]);
		 } 
	ELSE_TOK 
		{ 
			printf("%s: \n",symtable[$<type>1]);
		}
	'{' DEFINICE 
		{
			printf("%s: \n",symtable[$<type>2]);
		} 
	'}' 

RELACE:
	EXPRESSION 							
	|	EXPRESSION ASSIG_TOK EXPRESSION	
		{ 
			$<type>$ =	findOrCreateT($<type>1, $<type>3);
			printf("%s = %s ;\n", symtable[$<type>$], symtable[$<type>1]);		
			printf("%s = %s %s %s ;\n", symtable[$<type>$], symtable[$<type>$], $<assig>2, symtable[$<type>3]);
		}

WHILECOMMAND:
	WHILE_TOK '(' RELACE ')' 
	 	{
			int label = getlabel();
			$<type>1 = label;		
			printf("%s :\n", symtable[label]);
		}  
		'{' 
		{ 
			int label = getlabel();
			$<type>2 = label;			
			printf("if not %s goto %s\n", symtable[$<type>3], symtable[label]);
			while(tempcount > 1 ) tempcount--;
		}
		DEFINICE 
		{  printf("GOTO %s : \n",symtable[$<type>1]);}

		'}'   
		{  printf("%s: \n",symtable[$<type>2]);}
	


	
PRIRAZENI:
	IDENTIFIKATOR_TOK '=' VYRAZ 		
		{ 
			  printf("%s = %s ; \n",symtable[$<type>1], symtable[$<type>3]);
			  if(tempcount > 1) tempcount--;
		}
	| TYP PRIRAZENI


VYRAZ:
	EXPRESSION ';'


EXPRESSION:
	EXPRESSION '+' EXPRESSION			{ 
											$<type>$ =	findOrCreateT($<type>1, $<type>3); 	// najde nebo vztvori T v tabulce symblou
											printf("%s = %s + %s ;\n",symtable[$<type>$], symtable[$<type>1], symtable[$<type>3]);
										}
	|	EXPRESSION '-' EXPRESSION 		{ 
											$<type>$ = findOrCreateT($<type>1, $<type>3); 	
											printf("%s = %s - %s ;\n",symtable[$<type>$], symtable[$<type>1], symtable[$<type>3]);	 
										}
	|	EXPRESSION '*'  EXPRESSION 		{
											$<type>$ = findOrCreateT($<type>1, $<type>3); 	
											printf("%s = %s * %s ;\n",symtable[$<type>$], symtable[$<type>1], symtable[$<type>3]);	
										}
	|	EXPRESSION '/' EXPRESSION 		{
											$<type>$ = findOrCreateT($<type>1, $<type>3); 	
											printf("%s = %s * %s ;\n",symtable[$<type>$], symtable[$<type>1], symtable[$<type>3]);
										}
	|	'(' EXPRESSION ')' 				{ 
											$<type>$ = $<type>2;	 
										}
 	|	NUMBER_TOK
	|	IDENTIFIKATOR_TOK
	|	EXPRESSION

RETURN: 
	RETURN_TOK VYRAZ
	
%%



int findOrCreateT(int idx1, int idx3){

	int index = -1;
	int pomtemp = tempcount;
	while(pomtemp > 1){
		pomtemp--;
		char str[6];
		snprintf(str, 5, "T%i", pomtemp);
		str[5] = '\0';

		if(strcmp(str, symtable[idx1]) == 0) {
			index = idx1;
		}
		if(strcmp(str, symtable[idx3]) == 0) {
			index = idx3;
		}
	}
	
	if((-1 != index))

		return index;
	else
		return gettemp();
}


void yyerror (char *s)
{
	extern int yylineno;
	extern char *yytext;
	fprintf ( stderr, "%s Error at symbol /%s/ on line: %d\n", s,yytext, yylineno);
}

void printSymob(){
	int i = 0;
	printf("SYMBOL TABLE\n");
	while(i<symcount){
		printf("%d: %s\n", i, symtable[i]);
		i++;
	}
}

int main ()
{
  int i;

  if(!yyparse())
    printf("Gramatika je v poradku !!!\n");

}




int gettemp(void)
{

	int i = 0;
  	char str[6];
  	snprintf(str, 5, "T%i", tempcount++);
  	str[5] = '\0';


  	while(i < symcount && strcmp(str, symtable[i])) i++;

  	if(i<symcount)
    	return i;

  	strcpy (symtable[symcount], str);
  	return symcount++;
}




int getlabel(void)
{
  char str[6];
  snprintf(str, 5, "L%i", labelcount++);
  str[5] = '\0';
  strcpy (symtable[symcount], str);
  return symcount++;
}

