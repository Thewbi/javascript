# documentation

https://www.oreilly.com/library/view/flex-bison/9780596805418/ch01.html

# Install tools

```
brew install flex
brew upgrade flex
```

```
brew install bison
brew upgrade bison
```

# The Interface between Flex and Bison
When writing a bison grammar file (.y extension) the token that bison wants to consume are defined. During code generation, the -d bison flag generates a .tab.h file that contains definitions for all the token.

This .tab.h file is the interface between bison and flex because when writing a flex .l file, the same token names as contained in the .tab.h file are used. During compilation, the bison output, the flex output and the bison token table are combined which makes the compiler find all definitions and flex exactly outputs the token, that bison wants to consume.

# Generating the C++ Code From The Grammar
During code generation flex, the lexer generator and Bison the parser generator can be executed in any order because neither needs input from the other.

Flex processes the .l file, while Bison processes the .y file. Both output generated C++ source files following the logic defined in the .l and .y files.

To compile the generated files, all files from flex and bison are needed at the same time! bison is instructed to output the table of token using the -d flag. The token are referenced in the flex files!

The files output by flex need the files output by bison, because flex references the token constants to return them when it's lexer has identified a token.

Bison tries to reduce the rules using the token it gets from the token stream output by flex until the entire unit was processes.

The code that is triggered by a successfully reduced rule is defined by the user.

# Compilation
```
clang++ -std=c++17 -o wub grammar/lexer/lex.yy.c grammar/parser/es6.tab.c
```