%{
#include <stdio.h>
%}

%%
CREATE|DROP|ALTER|TRUNCATE                       {return DLL}          /*Data Definition Language*/
TABLE|SCHEMA|DATABASE                            {return TYPE}         /*Tipo de Estructura*/
SELECT|INSERT|DELETE|UPDATE                      {return DML}          /*Data Manipulation Language*/
FROM|WHERE|"GROUP BY"|HAVING|"ORDER BY"          {return CLAUS}        /*Cláusulas*/
AND|OR|NOT                                       {return LOGIC}        /*Operadores*/
INT|FLOAT|CHAR|VARCHAR|REAL                      {return TRANSACT}     /*Tipos de Datos*/
>|<|>=|<=|=|!=|<>                                {return RELAC}        /*Relaiones*/
\"[0-9a-zA-Z_ ]*\"|[0-9]+                        {return CONST}        /*Constante*/
[a-zA-Z_]+[,]?|[*]                               {return IDENT}        /*Identificadores*/
[ \t]
. printf("%s es: Caracter desconocido\n", yytext);
%%

int main() {
  printf("Ingrese una consulta SQL:\n");
  yylex();
  return 0;
}


