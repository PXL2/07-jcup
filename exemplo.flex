// --- Combined.flex ---
// Este ficheiro contém os tokens para a Calculadora, JSON e SQL.
import java_cup.runtime.Symbol;

%%

// --- Diretivas ---
%cup
%unicode
%line
%column
%class CombinedScanner

// --- Macros ---
// Calculadora
CALC_INTEIRO = [0-9]+

// JSON
JSON_STRING = \"[^\"]*\"
JSON_NUMBER = -?[0-9]+(\.[0-9]+)?

// SQL
SQL_ID = [a-zA-Z_][a-zA-Z0-9_]*
SQL_STRING_LITERAL = \'[^\']*\'
SQL_NUMBER_LITERAL = [0-9]+


%%
/* --- Regras Léxicas Combinadas --- */

// --- Tokens da Calculadora ---
{CALC_INTEIRO}  { return new Symbol(sym.CALC_INTEIRO, Integer.valueOf(yytext())); }
"+"             { return new Symbol(sym.MAIS); }
"-"             { return new Symbol(sym.MENOS); }
"*"             { return new Symbol(sym.VEZES); }
"/"             { return new Symbol(sym.DIVISAO); }
"%"             { return new Symbol(sym.RESTO); }
"^"             { return new Symbol(sym.POTENCIA); }
";"             { return new Symbol(sym.PTVIRG); } // Usado por Calculadora e SQL

// --- Tokens JSON ---
"{"             { return new Symbol(sym.LBRACE); }
"}"             { return new Symbol(sym.RBRACE); }
"["             { return new Symbol(sym.LBRACK); }
"]"             { return new Symbol(sym.RBRACK); }
":"             { return new Symbol(sym.COLON); }
","             { return new Symbol(sym.COMMA); }  // Usado por JSON e SQL
{JSON_STRING}   { return new Symbol(sym.JSON_STRING, yytext()); }
{JSON_NUMBER}   { return new Symbol(sym.JSON_NUMBER, Double.valueOf(yytext())); }
"true"          { return new Symbol(sym.TRUE); }
"false"         { return new Symbol(sym.FALSE); }
"null"          { return new Symbol(sym.NULL); }

// --- Tokens SQL ---
[sS][eE][lL][eE][cC][tT] { return new Symbol(sym.SELECT); }
[fF][rR][oO][mM]         { return new Symbol(sym.FROM); }
[wW][hH][eE][rR][eE]     { return new Symbol(sym.WHERE); }
"("                     { return new Symbol(sym.PARENTESQ); } // Usado por Calculadora e SQL
")"                     { return new Symbol(sym.PARENTDIR); } // Usado por Calculadora e SQL
{SQL_ID}                { return new Symbol(sym.SQL_ID, yytext()); }
{SQL_STRING_LITERAL}    { return new Symbol(sym.SQL_STRING_LITERAL, yytext()); }
{SQL_NUMBER_LITERAL}    { return new Symbol(sym.SQL_NUMBER_LITERAL, Integer.valueOf(yytext())); }
"="                     { return new Symbol(sym.OP_EQ); }
"<>"                    { return new Symbol(sym.OP_NEQ); }
">"                     { return new Symbol(sym.OP_GT); }
"<"                     { return new Symbol(sym.OP_LT); }
">="                    { return new Symbol(sym.OP_GTE); }
"<="                    { return new Symbol(sym.OP_LTE); }

// Ignora espaços em branco
[ \t\r\n]+              { /* Ignora */ }

// Caracteres inválidos
.                       { System.err.println("Caractere inválido: " + yytext()); }
