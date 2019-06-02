CC = gcc
LIBS = -lfl	 
LEX = flex
CFLAGS = -g -std=gnu99  
YACC = byacc -d -v -t  

 
all: project.exe

#-------------------------------------------------- 



project.exe: project.tab.o project.yy.o 
	${CC} -o project.exe project.tab.o project.yy.o ${LIBS} $(CFLAGS) 

project.tab.c project.tab.h: project.y
	${YACC} -o project.tab.c project.y

project.yy.c: project.l 
	${LEX} -o project.yy.c project.l


#-------------------------------------------------- 


test: test0 test1 test2 

test0:
	./project.exe < ./test_files/test1.txt

test1:  
	./project.exe < ./test_files/test2.txt

test2:    
	./project.exe < ./test_files/test3.txt
 

 #-------------------------------------------------- 

clear: clean
clean:
	rm -f *.yy.c *.tab.c
	rm -f *.tab.h
	rm -f *.o
	rm -f *.output *.stackdump
#	rm -f project.exe

