/*
Building / Generating code:
```
bison -d es6.y
````

Building the executable:
```
cd dev/cpp/javascript
clang++ -std=c++17 -o wub grammar/lexer/lex.yy.c grammar/parser/es6.tab.c
```


*/

%{

#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%token AWAIT

%token BREAK

%token CASE
%token CATCH
%token CLASS
%token COMMA
%token CONST
%token CONTINUE

%token DEBUGGER
%token DEFAULT
%token DELETE
%token DO

%token ELSE
%token ENUM
%token EQUALS
%token EXPORT
%token EXTENDS


%token FOR
%token FUNCTION
%token FINALLY

%token IDENTIFIER
%token INSTANCEOF
%token IN
%token IF
%token IMPORT
%token IMPLEMENTS
%token INTERFACE

%token LET

%token NEW
%token T_NULL

%token PACKAGE
%token PROTECTED
%token PRIVATE
%token PUBLIC

%token RETURN

%token SEMICOLON
%token SWITCH
%token SUPER

%token THIS
%token TYPEOF
%token TRY
%token THROW

%token VAR
%token VOID

%token WHILE
%token WITH

%token YIELD

%token NEWLINE

%start compilation_unit

%%

// https://gist.github.com/rbuckton/0d8c1f1c607f52f5ae37

/*
compilation_unit:
  AWAIT { printf("PARSER await found!\n"); }
  NEWLINE { printf("PARSER NEWLINE found! bye!\n"); exit(0); }
;
*/

compilation_unit:
  statement_list { printf("RULE compilation_unit.statement_list reduced!\n"); }
  ;

statement_list:
  statement_list_item { printf("RULE statement_list.statement_list_item A reduced!\n"); }
  | statement_list { printf("RULE statement_list.statement_list reduced!\n"); } statement_list_item { printf("RULE statement_list.statement_list_item B reduced!\n"); }
  ;

statement_list_item:
  statement { printf("RULE statement reduced!\n"); }
  ;

statement:
  variable_statement { printf("RULE variable_statement reduced!\n"); }
  ;

variable_statement:
  VAR { printf("RULE VAR reduced!\n"); } variable_declaration_list { printf("RULE variable_declaration_list reduced!\n"); } SEMICOLON { printf("RULE SEMICOLON reduced!\n"); }
  ;

/*
| variable_declaration_list COMMA variable_declaration
*/
variable_declaration_list:
  variable_declaration { printf("RULE variable_declaration reduced!\n"); }
  ;

variable_declaration:
  /* Rule for variable declaration without initializer */
  binding_identifier { printf("RULE binding_identifier reduced!\n"); }
  /* Rule for variable declaration with initializer */
  | binding_identifier { printf("RULE binding_identifier reduced!\n"); } initializer { printf("RULE initializer reduced!\n"); }
  ;

binding_identifier:
  identifier { printf("RULE identifier reduced!\n"); }
  ;

identifier:
  IDENTIFIER { printf("RULE IDENTIFIER reduced!\n"); }
  ;

initializer:
  EQUALS assignment_expression { printf("RULE assignment_expression reduced!\n"); }
  ;

/*
expression:
  assignment_expression
  ;
  */

/*
AssignmentExpression[In, Yield] :
   ConditionalExpression[?In, ?Yield]
   [+Yield] YieldExpression[?In]
   ArrowFunction[?In, ?Yield]
   LeftHandSideExpression[?Yield] = AssignmentExpression[?In, ?Yield]
   LeftHandSideExpression[?Yield] AssignmentOperator AssignmentExpression[?In, ?Yield]
*/

/*
| lefthandside_expression { printf("RULE lefthandside_expression reduced!\n"); } EQUALS { printf("RULE EQUALS reduced!\n"); } assignment_expression
*/
assignment_expression:
  conditional_expression { printf("RULE conditional_expression reduced!\n"); }
  ;

conditional_expression:
  logical_or_expression { printf("RULE logical_or_expression reduced!\n"); }
  ;

logical_or_expression:
  logical_and_expression { printf("RULE logical_and_expression reduced!\n"); }
  ;

logical_and_expression:
  bitwise_or_expression { printf("RULE bitwise_or_expression reduced!\n"); }
  ;

bitwise_or_expression:
  bitwise_xor_expression { printf("RULE bitwise_xor_expression reduced!\n"); }
  ;

bitwise_xor_expression:
  bitwise_and_expression { printf("RULE bitwise_and_expression reduced!\n"); }
  ;

bitwise_and_expression:
  equality_expression { printf("RULE equality_expression reduced!\n"); }
  ;

equality_expression:
  relational_expression { printf("RULE relational_expression reduced!\n"); }
  ;

relational_expression:
  shift_expression { printf("RULE shift_expression reduced!\n"); }
  ;

shift_expression:
  additive_expression { printf("RULE additive_expression reduced!\n"); }
  ;

additive_expression:
  multiplicative_expression { printf("RULE multiplicative_expression reduced!\n"); }
  ;

multiplicative_expression:
  unary_expression { printf("RULE unary_expression reduced!\n"); }
  ;

unary_expression:
  postfix_expression { printf("RULE postfix_expression reduced!\n"); }
  ;

postfix_expression:
  lefthandside_expression { printf("RULE lefthandside_expression reduced!\n"); }
  ;

lefthandside_expression:
  new_expression { printf("RULE new_expression reduced!\n"); }
  ;

new_expression:
  member_expression { printf("RULE member_expression reduced!\n"); }
  ;

member_expression:
  primary_expression { printf("RULE primary_expression reduced!\n"); }
  ;

primary_expression:
  literal { printf("RULE literal reduced!\n"); }
  ;

/*
  |  BooleanLiteral
  |  NumericLiteral
  |  StringLiteral
  */
literal:
  null_literal { printf("RULE null_literal reduced!\n"); }
  ;

null_literal:
  T_NULL { printf("RULE T_NULL reduced\n"); }
  ;

%%

int main() {
  printf("PARSER main()\n");

  // parse input from stdin
	//yyin = stdin;

  // parse input from a file
  FILE * pt = fopen("test.js", "r");
  if(!pt) {
    printf("Bad Input! No file found!\n");
    return -1;
  }

  yyin = pt;

	do {
    printf("PARSER Calling yyparse()");
		yyparse();
	} while(!feof(yyin));

  printf("PARSER return 0;\n");
	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "Parse error: %s\n", s);
	exit(1);
}
