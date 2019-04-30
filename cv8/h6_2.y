%{
void yyerror(char *);
int yylex(void);
%}

%token NUMBER
%left ????
%left ????
%nonassoc UMINUS UPLUS

%%

statement:	expression {printf("Value: %d\n",$1);}
	;

 expression:	expression '+' expression	{$$=$1+$3;}
          	|	dopln pro - ???
	        |	dopln pro *
	        |	dopln pro  /
	        |	'-' expression %prec UMINUS	{$$=-$2;}
	        |	'+' expression %prec UPLUS 	{$$=$2;}
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