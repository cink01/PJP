CC = gcc -g
LIBS = -lfl
LEX = flex -I 
CFLAGS = -DYYDEBUG=1

all:  h2_1 h2_3 h2_2

h2_1: lex1.yy.c 
	${CC} -o h2_1 lex1.yy.c ${LIBS}

lex1.yy.c: h2_1.l
	${LEX} -s -olex1.yy.c h2_1.l
	
h2_2: lex2.yy.c 
	${CC} -o h2_2 lex2.yy.c

lex2.yy.c: h2_2.l
	${LEX} -olex2.yy.c h2_2.l

h2_3: lex3.yy.c 
	${CC} -o h2_3 lex3.yy.c ${LIBS}

lex3.yy.c: h2_3.l
	${LEX} -olex3.yy.c h2_3.l

clean: 
	rm lex1.yy.c 
	rm lex2.yy.c
	rm lex3.yy.c
	rm h2_1 
	rm h2_2
	rm h2_3
