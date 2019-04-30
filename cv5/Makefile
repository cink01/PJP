CC = gcc
LIBS = -lfl	# Flex library
#LIBS = -ll	# 
LEX = flex	# -l turns on maximum compatibility with the original 
                # AT&T lex implementation. Note that this does not 
                # mean full compatibility. Use of this option costs
                # a considerable amount of performance,

CFLAGS = -DYYDEBUG=1 -g

all: h5_1

h5_1: lex1.yy.c 
	${CC} -o h5_1 lex1.yy.c ${LIBS} $(CFLAGS)

lex1.yy.c: h5_1.l
	${LEX} -o lex1.yy.c h5_1.l

clean: 
	rm -f lex1.yy.c 
	rm -f h5_1 