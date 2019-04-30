%{
void yyerror(char *);
int yylex(void);
%}

  /* add associativity and priority later */ 

%%

  /* define rules here */
  
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


