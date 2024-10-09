%{
#include <stdio.h>
%}

%%
SELECT|FROM|WHERE|INSERT|DELETE|UPDATE printf("%s es: Palabra Clave\n", yytext);
AND|OR|NOT  printf("%s es: Operador Logico\n", yytext);
>|<|>=|<=|=|!=|<> printf("%s es: Operador Relacional\n", yytext);
\"[0-9a-zA-Z_ ]*\"|[0-9]+ printf("%s es: Constante\n", yytext);
[a-zA-Z_]+[,]?|[*]  printf("%s es: Identificador\n", yytext);
[ \t]
. printf("%s es: Caracter desconocido\n", yytext);
%%

int main() {
  printf("Ingrese una consulta SQL:\n");
  yylex();
  return 0;
}


