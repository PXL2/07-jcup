import java_cup.runtime.*;

%%
%class QueryLexer
%cup
%unicode
%line
%column

%{
  private Symbol symbol(int type){
    return new Symbol(type, yyline, yycolumn);
  }
  private Symbol symbol(int type, Object value){
    return new Symbol(type, yyline, yycolumn, value);
  }

%}
// Professor nessa parte ele consegue ler numeros letras digitos id espacobrando 

letra = [a-zA-Z]
digito = [0-9]
id = {letra}({letra}|{digito})*
numero = {digito}+
espacobranco = [ \r\n\t]+ 

// professor aqui é a aprte crucial do flex que serve pra ensinar o nosso "leitor de texto" (o lexer) a identificar uma palavra específica no código.

%%
"FROM"    {return symbol(sym.FROM);}
"SELECT"  {return symbol(sym.SELECT);}
"WHERE"   {return symbol(sym.WHERE);}
"AND"     {return symbol(sym.AND);}
","       {return symbol(sym.VIRGULA);}
"="       {return symbol(sym.ATRIBUICAO);}
">"       {return symbol(sym.MAIORQUE);}
"<"       {return symbol(sym.MENORQUE);}
">="      {return symbol(sym.MAIORIGUAL);}
"<="      {return symbol(sym.MENORIGUAL);}
"!="      {return symbol(sym.NAOIGUAL);}
"*"       {return symbol(sym.TODOS);} 
{id}      {return symbol(sym.ID, yytext());}
{numero}  {return symbol(sym.NUMERO, Integer.valueOf(yytext()));}
\'([^\\']|\\.)*\' {return symbol(sym.STRING,
                            yytext().substring(1,
                                    yytext().length() - 1));}
{espacobranco} { /* IGNORE */ }

<<EOF>> { return symbol(sym.EOF);}

// Regra de erroS (CARACTERES NÃO RECONHECIDOS)
. { System.err.println("Erro léxico: Caractere inválido '" + yytext() + "' na linha " + (yyline+1) + ", coluna " + (yycolumn+1)); }