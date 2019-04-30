CC = gcc
LIBS = -lfl	
#LIBS = -ll	
LEX = flex	

CFLAGS = -DYYDEBUG=1 -g

all: h5_1

h5_1: lex1.yy.c 
	${CC} -o h5_1 lex1.yy.c ${LIBS} $(CFLAGS)

lex1.yy.c: h5_1.l
	${LEX} -o lex1.yy.c h5_1.l

clean: 
	rm -f lex1.yy.c 
	rm -f h5_1 