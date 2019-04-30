%{

/* definice jednotlivych tokenu */
#define a_TOK 0
#define b_TOK 1
#define c_TOK 2
#define d_TOK 3
#define e_TOK 4
#define f_TOK 5
#define g_TOK 6
#define h_TOK 7
#define NOT_CORRECT_TERMINAL -1

%}

%%
 /* terminaly -> pri nalezeni vrati prislusny token */
[ \t\n] ;
"a"  return(a_TOK);
"b"  return(b_TOK);
"c"  return(c_TOK);
"d"  return(d_TOK);
"e"  return(e_TOK);
"f"  return(f_TOK);
"g"  return(g_TOK);
"h"  return(h_TOK);
.  return(NOT_CORRECT_TERMINAL);

%%

int symbol;

int main()
{
	int err = 0;
	
	symbol = yylex();
	err = S();

	if (err == 0)
	{
		puts("Derivace rekurzivnim sestupem pro tento vstupni retezec je SPRAVNA");
	}
	else
	{
		puts("CHYBA, vstupni retezec napatri do zadane gramatiky");
	}
	return err;
}

/* S -> AB */
int S(void)
{
	int err = 0;

	puts("S -> AB");
	/* 
	err = A();
	if (err == 0)
	{
		err = B();
	}
	*/
	return err;
}

/* A' -> h | bAc | Bc */
int Ap(void)
{ 
	int err = 0;

	switch(symbol)
	{
	case h_TOK:
		puts("A' -> h");
		symbol = yylex();
		err = 0;
		break;
	case b_TOK:
		puts("A' -> bAc");
		symbol = yylex();
		err = A();
		if ( err == 0 && symbol == c_TOK)
		{
			err = 0;
			symbol = yylex();
		}
		else
		{
			err = -1;
		}
		break;
	default:
		puts("A' -> Bc");
		err = B();
		if (err == 0 && symbol == c_TOK)
		{
			err = 0;
			symbol = yylex();
		}
		else
		{
			err = -1;
		}
	}
	return err;
}




/* Other rules here */
