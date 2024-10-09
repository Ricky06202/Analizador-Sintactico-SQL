CC = gcc
LIB = -lfl -L /usr/bin/flex/bin
o ?= ejemplo9
all: $(o).x
lex: lex.yy.c
bison: y.tab.c
yacc: bison
flex: lex
lex.yy.c: $(o).l
	flex $(o).l
y.tab.c: $(o).l
	bison -dy $(o).y
y.tab.h: $(o).y


$(o).x: lex.yy.c y.tab.c y.tab.h
	$(CC) lex.yy.c y.tab.c -o $(o).out $(LIB)

clean:
	rm lex.yy.c
	rm *.out
	rm y.tab.c
	rm y.tab.h
