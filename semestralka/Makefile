CC = gcc
LIBS = -lfl 	# Linux
LEX = flex	# -l turns  on  maximum  compatibility with the original 
                # AT&T lex implementation.  Note that this does not 
                # mean full  compatibility.   Use  of  this
                # option costs a considerable amount of performance,
BISON = bison -d 
CFLAGS = -DYYDEBUG=1 -g -Wall -pedantic

DEP1=sp.tab.c sp.yy.c
EXE1=sp.exe

.SUFFIXES:                    # Delete the default suffixes
.SUFFIXES: .y .tab.c .l .yy.c # Define our suffix list

.y.tab.c:
	$(BISON) $<

.l.yy.c:
	$(LEX) -o$@ $<

all: $(EXE1) sp.h

$(EXE1): $(DEP1) sp.h
	$(CC) -o $(EXE1) $(DEP1) $(LIBS) $(CFLAGS)
# ---------------------------------------------
test: test1 test2 test3

test1:
	./sp.exe < test1
test2:
	./sp.exe < test2
test3:
	./sp.exe < test3
# --------------------------------------------
help:	
	./sp.exe -h
# --------------------------------------------
clear: clean
clean: 
	rm -f *.tab.h core $(DEP1) *.o $(EXE1) *~
