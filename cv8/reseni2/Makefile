CC = gcc
#LIBS = -lfl -lm 	# Linux
LIBS = -ll -lm		# Sun
LEX = flex -I		# -d turns on debugging

BISON = bison -d -t -v  # -v or 
CFLAGS = -DYYDEBUG=1 -g # -DYYDEBUG=1 for debugging

DEP1=h7.tab.c h7.yy.c

.SUFFIXES:                    # Delete the default suffixes
.SUFFIXES: .y .tab.c .l .yy.c # Define our suffix list

.y.tab.c:
	$(BISON) $<

.l.yy.c:
	$(LEX) -o$@ $<

all: h7

h7: $(DEP1)
	$(CC) -o h7 $(DEP1) $(LIBS) $(CFLAGS)

clean: 
	rm -f *.c *.h *.o h7
