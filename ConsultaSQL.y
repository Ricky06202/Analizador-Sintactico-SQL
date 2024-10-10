%{
    #include <stdio.h>
#include <string.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
}%

%token DLL, TYPE, DML, CLAUS LOGIC, TRANSACT, RELAC, CONST, IDENT
%start input

%% /*Aqui va las instrucciones como si trabajaramos con GLC*/

/* entrada de la consulta sql */
input: /* entrada vacia */
    | input consult {printf("Consulta correcta. \n")}
    | input "salir" {printf("Saliendo del programa. \n"); exit(0)}
    ;

/*Consultas*/
consult: commandDLL
    | commandDML
    ;

/*Comandos para CREATE, DROP, ALTER y TRUNCATE*/
commandDLL: DLL TYPE INDET
    | commandDLL '(' fieldsDLL ')'
    ;

/*Comandos para INSERT SELECT UPDATE y DELETE*/
commandDML: DML identifier CLAUS identifier
    | commandDML CLAUS identifier
    | commandDML '(' fieldsDML ')' "VALUES" '(' fieldsDML ')'
    ;

/*campos de la tabla */
fieldsDLL: identifier identifier '(' CONST ')'
    | "," fields
    ;

fieldsDML: identifier
    | "," fields
    ;

/*detectar nombre del identificador*/
identifier: INDET
    | CONST
    ;

%%