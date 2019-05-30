CC = gcc
LIBS = -ll -lm 
LEX = lex -I	
BISON = bison -d -t -v 
CFLAGS = -DYYDEBUG=1 -g 

DEP=sp.tab.c sp.yy.c
EXE=sp.exe

.SUFFIXES:                    # Delete the default suffixes
.SUFFIXES: .y .tab.c .l .yy.c # Define our suffix list

.y.tab.c:
	$(BISON) $<

.l.yy.c:
	$(LEX) -o $@ $<

all: $(EXE) 

$(EXE): $(DEP) 
	$(CC) -o $(EXE) $(DEP) $(LIBS) $(CFLAGS)
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
	rm -f *.tab.h core $(DEP) *.output $(EXE) *~
