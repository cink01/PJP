%{
void yyerror(char *);
int yylex(void);
%}

%token NUMBER
%left '+', '-'
%left '*', '/'
%nonassoc UNIM
%nonassoc UNIP	

%%

expression: expression '+' expression 
	| expression '-' expression
	| expression '*' expression 
	| expression '/' expression 
	| '-' expression %prec UNIM 
	| '+' expression %prec UNIP 
	| '(' expression ')' 
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


