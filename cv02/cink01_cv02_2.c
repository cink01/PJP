/*
  FILE: main.c

  DESCRIPTION:
      Compiler construction.

  AUTHORS:
  	Jan Vorace, Joni Kamarainen, Jarno Mielikainen
	Modified by Kari Jyrkinen, Jarmo Ilonen, Arto Kaarna

 */

#include <stdio.h> /* IO */
#include <ctype.h>

//typedef int ParserState;

#define STATE_INIT 1
#define STATE_INIT_A 2
#define STATE_INIT_B 3
#define STATE_HEAD_OK 4
#define STATE_END_A 5
#define STATE_END_B 6
#define STATE_OK 7
#define STATE_ERR 8
#define STATE_UNKNOWN 8

/* internals */
int nextState(int state, char input);
int a(int state);
int b(int state);
int other(int state);

int main(int argc, char **argv)
{
	int state = STATE_INIT;
	char c;
	int i = 0;

	if (argc < 2)
	{
		puts("Word not given");
		return 1;
	}

	while ((c = *(argv[1]+i++)) != '\0')
	{
	  /* A character can not be a capital letter and it should be alphanumeric. */
	  if ((c<65 || c>90) && isalnum(c))
	    {
	      state = nextState(state, c);
	    }
	  else
	    {
	      state = STATE_ERR;
	    }
	}

	if (state == STATE_OK)
	{
		puts("The given word is derived from the language ^(ab|ba)[c-z0-9]*(ab|ba)$");
	}
	else
	{
		puts("Language definition doesn't match with the given word.");
	}
	return 0;
}

int nextState(int state, char input)
{
	int newState;

	switch (input)
	{
	case 'a':
		newState = a(state);
		break;

	case 'b':
		newState = b(state);
		break;

	default:
		newState = other(state);

	};
	return newState;
}

int a(int state)
{
        switch (state)
        {
        case STATE_INIT:
                return STATE_INIT_A;
                break;

	    case STATE_INIT_B:
	    		return STATE_HEAD_OK;
	    		break;
	    case STATE_HEAD_OK:
	    		return STATE_END_A;
	    		break;
		case STATE_END_B:
				return STATE_OK;
				break;

	    }
                return STATE_UNKNOWN;
}


int b(int state)
{
        switch (state)
        {
        case STATE_INIT:
                return STATE_INIT_B;
                break;

	    case STATE_INIT_A:
	    		return STATE_HEAD_OK;
	    		break;
	    case STATE_HEAD_OK:
	    		return STATE_END_B;
	    		break;
		case STATE_END_A:
				return STATE_OK;
				break;

	    }
        return STATE_UNKNOWN;
}


int other(int state)
{
   switch (state)
        {
        case STATE_HEAD_OK:
                return STATE_HEAD_OK;
                break;
             }
        return STATE_UNKNOWN;
}
