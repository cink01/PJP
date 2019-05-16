%{
void yyerror(char *);
int yylex(void);
int sym[26];
%}

%union	{ 
			float num;
			char *id;
		};
%start program
%token <num> NUMBER
%token <id> ID
%type<num> expression
%type<num> statement

%left '+' '-'
%left '*' '/'
%nonassoc UNIM
%nonassoc UNIP	

%%

program: program statement '\n' 
	| 
	;

statement:	expression { printf("%d\n", $1)}
	| ID '=' expression {sym[$1]= $3;}
	;


expression: NUMBER
	| ID {$$=sym[$1];}
	| expression '+' expression {$$=$1+$3}
	| expression '-' expression {$$=$1-$3}
	| expression '*' expression {$$=$1*$3}
	| expression '/' expression {$$=$1/$3}
	| '-' expression %prec UNIM {$$=-$2}
	| '+' expression %prec UNIP {$$=$2}
	| '(' expression ')' { $$ =  $2; }
	;

  
%%

void yyerror (char *s)
{
  fprintf (stderr, "%s\n", s);
  return 0;
}

int main ()
{
  if(!yyparse ())
    printf("OK\n");
  return 0;
}


