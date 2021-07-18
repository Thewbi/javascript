/*
Based on:
https://262.ecma-international.org/6.0/#sec-ecmascript-language-lexical-grammar

Flex:
http://dinosaur.compilertools.net/flex/manpage.html
https://westes.github.io/flex/manual/Simple-Examples.html#Simple-Examples

Installation:
$ brew install flex
$ brew upgrade flex

Check your version:
$ flex --version
You need at least: 2.6
Tested with 2.6.4

Does not work with:
flex 2.5.35 Apple(flex-31)

If homebrew does not install 2.6, try macports
$ sudo port selfupdate
$ sudo port install flex
Check where macports installed flex on your system
$ port -q contents flex
Output the version
$ /opt/local/bin/flex --version
Output is: flex 2.6.4

Building:
$ cd grammar/lexer
$ /opt/local/bin/flex es6.l
This generates lex.yy.c which now has to be compiled
$ clang++ -std=c++17 -o es6 lex.yy.c

Running:
$ ./es6
Now the app waits for input to scan and tokenize from stdin.
That means whatever you type into the console at this point
is processed by flex until you abort the application with
Ctrl + c

Quickly building and running:
rm es6 & /opt/local/bin/flex es6.l & clang++ -std=c++17 -o es6 lex.yy.c

File Structure:

%{
  C header and declarations go here
%}
Bison definitions
%%
Grammar rules ...
%%
User C code ...

or, simpler:

definitions
%%
rules
%%
user code

*/

/* https://stackoverflow.com/questions/2612394/unable-to-compile-output-of-lex

Prevents the error:
   Undefined symbols for architecture x86_64:
  "_yywrap", referenced from:
      yylex()
*/


/* just like Unix wc */
%{

int chars = 0;
int words = 0;
int lines = 0;

#include "es6.tab.h"

//#define AWAIT 257
//#define BREAK 258

%}

DIGIT [0-9]
IDENTIFIER [a-z][a-z0-9]*

/* read only one input file */
%option noyywrap

%%

[ \t]       ;
\n          { printf("newline detected - "); /*return NEWLINE;*/ }

"await"       { printf("await detected - "); return AWAIT; }

"break"       { printf("break detected - "); return BREAK; }

"case"       { printf("case detected - "); return CASE; }
"catch"       { printf("catch detected - "); return CATCH; }
"class"       { printf("class detected - "); return CLASS; }
"const"       { printf("const detected - "); return CONST; }
"continue"       { printf("continue detected - "); return CONTINUE; }

"debugger"       { printf("debugger detected - "); return DEBUGGER;}
"default"       { printf("default detected - "); return DEFAULT;}
"delete"       { printf("delete detected - "); return DELETE;}
"do"       { printf("do detected - "); return DO;}

"else"       { printf("else detected - "); return ELSE;}
"export"       { printf("export detected - "); return EXPORT; }
"extends"       { printf("extends detected - "); return EXTENDS;}
"enum"       { printf("enum detected - "); return ENUM;}

"for"       { printf("for detected - "); return FOR;}
"function"       { printf("function detected - "); return FUNCTION;}
"finally"       { printf("finally detected - "); return FINALLY;}

"instanceof"       { printf("instanceof detected - "); return INSTANCEOF;}
"in"       { printf("in detected - "); return IN;}
"if"       { printf("if detected - "); return IF;}
"import"       { printf("import detected - "); return IMPORT;}
"implements"       { printf("implements detected - "); return IMPLEMENTS;}
"interface"       { printf("interface detected - "); return INTERFACE;}

"let"       { printf("let detected - "); return LET;}

"new"       { printf("new detected - "); return NEW;}
"null"      { printf("null detected - "); return T_NULL;}

"package"       { printf("package detected - "); return PACKAGE;}
"protected"       { printf("protected detected - "); return PROTECTED; }
"private"       { printf("private detected - "); return PRIVATE; }
"public"       { printf("public detected - "); return PUBLIC; }

"return"       { printf("return detected - "); return RETURN; }

"switch"       { printf("switch detected - "); return SWITCH; }
"super"       { printf("super detected - "); return SUPER; }

"this"       { printf("this detected - "); return THIS; }
"typeof"       { printf("typeof detected - "); return TYPEOF; }
"try"       { printf("try detected - "); return TRY; }
"throw"       { printf("throw detected - "); return THROW; }

"var"       { printf("var detected - "); return VAR; }
"void"       { printf("void detected - "); return VOID; }

"while"       { printf("while detected - "); return WHILE; }
"with"       { printf("with detected - "); return WITH; }

"yield"       { printf("yield detected - "); return YIELD; }

"{"         { printf("{ detected - "); }
"("         { printf("( detected - "); }
")"	         { printf(") detected - "); }
"["        { printf("[ detected - "); }
"]"         { printf("] detected - "); }
"."          { printf(". detected - "); }
"..."          { printf("... detected - "); }
";"          { printf("; detected - "); return SEMICOLON; }
","          { printf(", detected - "); return COMMA; }
"<"         { printf("< detected - "); }
">"         { printf("> detected - "); }
"<="         { printf("<= detected - "); }
">="         { printf(">= detected - "); }
"=="         { printf("== detected - "); }
"!="	         { printf("!= detected - "); }
"==="	         { printf("=== detected - "); }
"!=="         { printf("!== detected - "); }
"+"	         { printf("+ detected - "); }
"-"	         { printf("- detected - "); }
"*"	         { printf("* detected - "); }
"%"	         { printf("%% detected - "); }
"++"         { printf("++ detected - "); }
"--"         { printf("-- detected - "); }
"<<"	         { printf("<< detected - "); }
">>"	         { printf(">> detected - "); }
">>>"	         { printf(">>> detected - "); }
"&"	         { printf("& detected - "); }
"|"	         { printf("| detected - "); }
"^"         { printf("^ detected - "); }
"!"	         { printf("! detected - "); }
"~"	         { printf("~ detected - "); }
"&&"	         { printf("&& detected - "); }
"||"	         { printf("|| detected - "); }
"?"	         { printf("? detected - "); }
":"         { printf(": detected - "); }
"="	         { printf("= detected - "); return EQUALS; }
"+="	         { printf("+= detected - "); }
"-="	         { printf("-= detected - "); }
"*="	         { printf("*= detected - "); }
"%="	         { printf("%%= detected - "); }
"<<="         { printf("<<= detected - "); }
">>="	         { printf(">>= detected - "); }
">>>="	         { printf(">>>= detected - "); }
"&="	         { printf("&= detected - "); }
"|="	         { printf("|= detected - "); }
"^="	         { printf("^= detected - "); }
"=>"         { printf("=> detected - "); }

{DIGIT}         { printf("DIGIT detected - "); }
{IDENTIFIER}         { printf("Identifier detected - "); return IDENTIFIER; }

.           { printf("unknown char detected - "); }

%%

/*
int main(int argc, char **argv)
{
  yylex();
  //printf("%8d%8d%8d\n", lines, words, chars);
  printf("done");

  return 0;
}
*/