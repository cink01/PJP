%{

/* lets define tokens for terminals */
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
 /* terminals -> return found token */
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
		puts("OK, aktualni vstup je generovan zadanou gramatikou");
	}
	else
	{
		puts("CHYBA, vstupni retezec nepatri do zadane gramatiky!");
	}
	return err;
}

/* S - AB */   //vola jen fce AB
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

/* A -> aA' */     //narazí na malé a je to v pořádku a čte další symbol
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

/* B -> CDE */
int B(void)
{
	int err = 0;

	puts("B -> CDE");
	err = C();
	if (err == 0)
	{
		err = D();
	}
	if (err == 0)
	{
		err = E();
	}
	return err;
}

int C(void)
{
	int err = 0;
	
	switch (symbol)
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
	int err = 0;
	
	if (symbol == f_TOK)
	{
		puts("D -> fD'");
		symbol = yylex();
		err = Dp();
	}
	return err;
}

/* D' -> fD' | epsilon */
int Dp(void)
{
	int err = 0;

	if (symbol == f_TOK)
	{
		puts("D' -> fD'");
		symbol = yylex();
		err = Dp();
	}
	else
	{
		puts("D' -> epsilon");
		err = 0;
	}
	return err;
}

int E(void)
{
	int err = 0;

	switch (symbol)
	{
	case g_TOK:
		puts("E -> g");
		symbol = yylex();
		err = 0;
		break;
	default:
		puts("E -> B");
		err = B();
	}
	return err;
}



