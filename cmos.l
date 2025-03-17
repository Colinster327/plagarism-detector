%{
  #include <iostream>
  #include <fstream>
  #include <iomanip>

  using namespace std;

  #define TK_IDENTIFIER 001
  #define TK_TYPE 002
  #define TK_KEYWORD 003
  #define TK_L_BRACE 004
  #define TK_R_BRACE 005
  #define TK_L_CURLY 006
  #define TK_R_CURLY 007
  #define TK_L_PAREN 010
  #define TK_R_PAREN 011
  #define TK_INCLUDE 012
  #define TK_FOR 013
  #define TK_WHILE 014
  #define TK_DO 015
  #define TK_IF 016
  #define TK_ELSE 017
  #define TK_RETURN 020
%}

COMMENT "/*"([^*]|\*+[^*/])*\*+"/"
CPP_COMMENT "//".*
V_NAME [a-zA-Z_][a-zA-Z0-9_]*
V_TYPE "int"|"char"|"void"|"float"|"double"
INCLUDE "#include"[\t ]*"<"[a-zA-Z0-9_./]*">"
INCLUDE_H "#include"[\t ]*"\""[a-zA-Z0-9_./]*"\""

%%

[ \t\n\f\r\v] { /* Ignore whitespace */ }
{COMMENT} { /* Ignore comments */ }
{CPP_COMMENT} { /* Ignore comments */ }
{INCLUDE}|{INCLUDE_H} { return TK_INCLUDE; }
{V_TYPE} { return TK_TYPE; }
"[" { return TK_L_BRACE; }
"]" { return TK_R_BRACE; }
"{" { return TK_L_CURLY; }
"}" { return TK_R_CURLY; }
"(" { return TK_L_PAREN; }
")" { return TK_R_PAREN; }
"for" { return TK_FOR; }
"while" { return TK_WHILE; }
"do" { return TK_DO; }
"if" { return TK_IF; }
"else" { return TK_ELSE; }
"return" { return TK_RETURN; }
[\*&]?{V_NAME} { return TK_IDENTIFIER; }
. { /* Ignore unknown characters */ }

%%

int yywrap() {
  return 1;
}

int main() {
  fstream file("scanner_out.txt", ios::out); 
  int token;

  // Read tokens from input file and write to output file
  while ((token = yylex())) {
    file << setw(3) << setfill('0') << token; 
  }

  file.close();
}
