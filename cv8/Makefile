CC = gcc
LIBS = -lfl	
LEX = flex -I	
BISON = bison -d -v
CFLAGS = -DYYDEBUG=1 -g

DEP1=h8_2.tab.c h8_2.yy.c
DEP2=h8.tab.c h8.yy.c 


.SUFFIXES:                   
.SUFFIXES: .y .tab.c .l .yy.c 

.y.tab.c:
	$(BISON) $<

.l.yy.c:
	$(LEX) -o$@ $<

all: h8 h8_2

h8: $(DEP2)
	$(CC) -o h8 $(DEP2) $(LIBS) $(CFLAGS)

h8_2: $(DEP1)
	$(CC) -o h8_2 $(DEP1) $(LIBS) $(CFLAGS)

clean: 
	rm -f *.c *h *.o h8 h8_2
