%{
#include <stdio.h>
#include <string.h>
#include "ConsultaSQL.tab.h"
%}



%%
"SALIR"|"EXIT"                                   {return SALIR;}        /*Comando para salir del programa*/  

"CREATE"                                         {return CREATE;}       /*Data Definition Language*/
"DROP"                                           {return DROP;}          
"ALTER"                                          {return ALTER;}          
"TRUNCATE"                                       {return TRUNCATE;}     

"TABLE"                                          {return TABLE;}        /*Tipo de Estructura*/
"SCHEMA"                                         {return SCHEMA;}   
"DATABASE"                                       {return DATABASE;}

"SELECT"                                         {return SELECT;}       /*Data Manipulation Language*/
"INSERT INTO"                                    {return INSERT;}  
"DELETE"                                         {return DELETE;}  
"UPDATE"                                         {return UPDATE;}  

"FROM"                                           {return FROM;}         /*Cláusulas*/
"SET"                                            {return SET;}  
"WHERE"                                          {return WHERE;}  
"GROUP BY"                                       {return GROUP;}  
"ORDER BY"                                       {return ORDER;}
"ADD"                                            {return ADD;} 
"VALUES"                                         {return VALUES;}

"AND"|"OR"|"NOT"                                 {return LOGIC;}        /*Operadores*/
"ASC"                                            {return ASC;}          /*Orden ascendente y descendente*/
"DESC"                                           {return DESC;}

[0-9]+                                           {return NUM;}          /*Número*/
INT|FLOAT|CHAR|VARCHAR|REAL                      {return TRANSACT;}     /*Tipos de Datos*/
>|<|>=|<=|=|!=|<>                                {return RELAC;}        /*Relaciones*/
\"[0-9a-zA-Z_ ]*\"|[0-9]+                        {return CONST;}        /*Constante*/
[a-zA-Z_]+[,]?|[*]                               {return IDENT;}        /*Identificadores*/
"'"                                              {return QUOTE;}        /*Comilla simple*/
"("                                              {return ParentesisA;}   
")"                                              {return ParentesisC;}   
","                                              {return COMMA;}   
";"                                              {return SEMICOLON;}    /*Punto y coma final*/
[ \t]
. printf("Se esperaba un identificador valido, pero se encontro: %s\n", yytext);
%%

int yywrap() {
    return 1;
}


