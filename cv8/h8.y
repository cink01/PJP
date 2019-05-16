%{
void yyerror(char *);
int yylex(void);
%}

%token NUMBER
%left '+' '-'
%left '*' '/'
%nonassoc UniM UniP

%%

statement:	expression {printf("Value: %d\n",$1);}
	;

 expression:	expression '+' expression	{$$=$1+$3;}
          	|	expression '-' expression	{$$=$1-$3;}
	        |	expression '*' expression	{$$=$1*$3;}
	        |	expression '/' expression	{$$=$1/$3;}
	        |	'-' expression %prec UniM	{$$=-$2;}
	        |	'+' expression %prec UniP 	{$$=$2;}
        	|	'(' expression ')'	{$$=$2;}
	        |	NUMBER
	;

%%

void yyerror (char *s)
{
  fprintf (stderr, "%s\n", s);
}

int main ()
{
  if(!yyparse ())
    printf("OK\n");
}