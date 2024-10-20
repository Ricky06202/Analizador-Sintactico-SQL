%{
#include <stdio.h>
#include "ConsultaSQL.tab.h"
%}

%%
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
"HAVING"                                         {return HAVING;}  
"ORDER BY"                                       {return ORDER;}
"ADD"                                            {return ADD;} 
"VALUES"                                         {return VALUES;} 

"AND"|"OR"|"NOT"                                 {return LOGIC;}        /*Operadores*/

INT|FLOAT|CHAR|VARCHAR|REAL                      {return TRANSACT;}     /*Tipos de Datos*/
>|<|>=|<=|=|!=|<>                                {return RELAC;}        /*Relaciones*/
\"[0-9a-zA-Z_ ]*\"|[0-9]+                        {return CONST;}        /*Constante*/
[a-zA-Z_]+[,]?|[*]                               {return IDENT;}        /*Identificadores*/
[0-9]+                                           {return NUM;}          /*Número*/
"("                                              {return ParentesisA;}   
")"                                              {return ParentesisC;}   
","                                              {return COMMA;}   
";"                                              {return SEMICOLON;}    /*Punto y coma final*/
[ \t]
. printf("Error léxico: %s\n", yytext);
%%

int yywrap() {
    return 1;
}


