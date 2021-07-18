all: es6

es6.tab.c es6.tab.h: grammar/parser/es6.y
	bison -t -v -d grammar/parser/es6.y

lex.yy.c: grammar/lexer/es6.l es6.tab.h
	flex -d grammar/lexer/es6.l

es6: lex.yy.c es6.tab.c es6.tab.h
	gcc -o es6 es6.tab.c lex.yy.c

clean:
	rm es6 es6.tab.c grammar/parser/es6.tab.c es6.tab.h grammar/parser/es6.tab.h lex.yy.c grammar/lexer/lex.yy.c es6.output