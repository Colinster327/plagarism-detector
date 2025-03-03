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
%}

V_NAME [a-zA-Z_][a-zA-Z0-9_]*
V_TYPE "int"|"char"|"void"|"float"|"double"
KEYWORD "for"|"while"|"do"|"if"|"else"|"return"
INCLUDE "#include"[\t ]*"<"[a-zA-Z0-9_./]*">"

%%

[ \t\n\f\r\v] { /* Ignore whitespace */ }
"/*"([^*]|\*+[^*/])*\*+"/"  { /* Ignore comments */ }
"//".*  { /* Ignore comments */ }
{INCLUDE} { return TK_INCLUDE; }
{V_TYPE} { return TK_TYPE; }
{KEYWORD} { return TK_KEYWORD; }
"[" { return TK_L_BRACE; }
"]" { return TK_R_BRACE; }
"{" { return TK_L_CURLY; }
"}" { return TK_R_CURLY; }
"(" { return TK_L_PAREN; }
")" { return TK_R_PAREN; }
[\*&]?{V_NAME} { return TK_IDENTIFIER; }
. { /* Ignore unknown characters */ }

%%

int yywrap() {
  return 1;
}

int main() {
  fstream file("scanner_out.txt", ios::out); 
  int token;

  while ((token = yylex())) {
    file << setw(3) << setfill('0') << token; 
  }

  file.close();
}
