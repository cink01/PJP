CC = gcc
LIBS = -lfl	# Linux
#LIBS = -ll 	# Sun
LEX = flex 	# -l turns  on  maximum  compatibility with the original 
                # AT&T lex implementation.  Note that this does not 
                # mean full  compatibility.   Use  of  this
                # option costs a considerable amount of performance,
BISON = bison -d
CFLAGS = -DYYDEBUG=1 -g -Wall -pedantic

DEP1=h10_1.tab.c h10_1.yy.c
#DEP2=h10_2.tab.c h10_2.yy.c
EXE1=h10_1
#EXE2=h10_2

.SUFFIXES:                    # Delete the default suffixes
.SUFFIXES: .y .tab.c .l .yy.c # Define our suffix list

.y.tab.c:
	$(BISON) $<

.l.yy.c:
	$(LEX) -o$@ $<

#all: $(EXE1) $(EXE2)
all: $(EXE1)

$(EXE1): $(DEP1) h10.h
	$(CC) -o $(EXE1) $(DEP1) $(LIBS) $(CFLAGS)

#$(EXE2): $(DEP2) h10.h
#	$(CC) -o $(EXE2) $(DEP2) $(LIBS) $(CFLAGS)

clean: 
	rm -f *.tab.h core $(DEP1) $(DEP2) *.o $(EXE1) $(EXE2) *~

