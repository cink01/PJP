CC = gcc
LIBS = -lfl	# Linux
#LIBS = -ll	# Sun
LEX = flex -I	# -l turns  on  maximum  compatibility with the original 
                # AT&T lex implementation.  Note that this does not 
                # mean full  compatibility.   Use  of  this
                # option costs a considerable amount of performance,
BISON = bison -d -v
CFLAGS = -DYYDEBUG=1 -g

DEP1=h6_1.tab.c h6_1.yy.c
DEP2=h6_2.tab.c h6_2.yy.c


.SUFFIXES:                    # Delete the default suffixes
.SUFFIXES: .y .tab.c .l .yy.c # Define our suffix list

.y.tab.c:
	$(BISON) $<

.l.yy.c:
	$(LEX) -o$@ $<

all: h6_1 h6_2

h6_1: $(DEP1)
	$(CC) -o h6_1 $(DEP1) $(LIBS) $(CFLAGS)

h6_2: $(DEP2)
	$(CC) -o h6_2 $(DEP2) $(LIBS) $(CFLAGS)

clean: 
	rm -f *.c *h *.o h6_1 h6_2
