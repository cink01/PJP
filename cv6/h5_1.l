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
	err = A();
	if (err == 0)
	{
		err = B();
	}
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

/*A -> aA' */
int A(void)
{
	int err;
	if (symbol == a_TOK)
	{
		puts("A -> aA'");
		symbol = yylex();
		err = Ap();
	}
	else
	{
		err = -1;
	}
	return err;
}

/* B -> CDE */
int B(void)
{
	int err = 0;
	puts("B -> CDE");
	err = C();
	if (err == 0)
	{
		err = D();
		if(err ==0)
		{
			err = E();
		}
		else
		{ 
			err =-1;
		}
	}
	else
	{ 
		err =-1;
	}
	return err;
}

/* C -> d | e */
int C(void)
{
	int err = 0;
	switch(symbol)
	{
	case d_TOK:
		puts("C -> d");
		symbol = yylex();
		err = 0;
		break;
	case e_TOK:
		puts("C -> e");
		symbol = yylex();
		err = 0;
		break;
	default:
		err = -1;
	}
	return err;
}

/* D -> fD' */
int D(void)
{
	int err;
	if(symbol == f_TOK)
	{
		puts(" D -> fD'");
		symbol = yylex();
		err = Dp();
	}
	else
	{
		err =-1;
	}
	return err;
}

/* D' -> fD' | ε */
int Dp(void)
{
	int err;
	if (symbol == f_TOK)
	{
		puts("D' -> fD'");
		symbol = yylex();
		err = Dp();
	}
	else
	{
		puts("D' -> ε");
		err = 0;
	}
	return err;
}

/* E -> B | g  */
int E(void)
{
	int err = -1;
	switch(symbol)
	{
	case g_TOK:
		puts("E -> g");
		symbol = yylex();
		err = 0;
		break;
	default:
		/*
		if(symbol !=a_TOK ||symbol !=b_TOK ||symbol !=c_TOK ||symbol !=d_TOK ||symbol !=e_TOK ||symbol !=f_TOK ||symbol !=h_TOK )
		//osetreni toho, zda neni zadan jiny terminal na vstup pro pravidlo E nez terminal g nebo neterminal B
		{
			err =-1;
		}
		else
		{
		*/
			puts("E -> B");
			err = B();
		/*}*/
	}
	return err;
}