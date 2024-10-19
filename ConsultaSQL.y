/*Aqui va los paquetes */
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);

%}

/*Aqui va los token para identificar cada palabra o cadena */
/* %token DLL TYPE DML CLAUS LOGIC TRANSACT RELAC CONST IDENT */

/*Data Definition Language*/
%token CREATE DROP ALTER TRUNCATE
/*Tipo de Estructura*/
%token TABLE SCHEMA DATABASE
/*Data Manipulation Language*/
%token SELECT INSERT DELETE UPDATE
/*Cláusulas*/
%token FROM SET WHERE GROUP HAVING ORDER ADD VALUES
/*Operadores*/
%token LOGIC
/*Tipos de datos, relaciones, constantes, identificadores y números*/
%token TRANSACT RELAC CONST IDENT NUM


%% /*Aqui va las instrucciones como si trabajaramos con GLC*/

/* Entrada de la consulta sql */
input: /* entrada vacia */
    | input consult {printf("Consulta correcta. \n")}
    | input 'salir' {printf("Saliendo del programa. \n"); exit(0)}
    ;

/*Consultas*/
consult: commandDLL
    | commandDML
    ;

/*Comandos para CREATE, DROP, ALTER y TRUNCATE*/
commandDLL: CREATE TABLE identifier '(' fieldsDLL ')' ';'
    | DROP TABLE identifier ';'
    | ALTER TABLE identifier ADD identifier TRANSACT '(' NUM ')' ';'
    | TRUNCATE TABLE identifier ';'
    ;

/*Comandos para INSERT SELECT UPDATE y DELETE*/
commandDML: selectCondition ';'
    | INSERT identifier '(' fieldsDML ')' VALUES '(' fieldsDML ')' ';'
    | UPDATE identifier SET whereCondition ';'
    | DELETE FROM identifier whereCondition ';'
    ;

/*Campos de la tabla */
fieldsDLL: identifier TRANSACT '(' NUM ')'
    | ',' fieldsDLL
    ;

/*Campos de los datos */
fieldsDML: identifier
    | ',' fieldsDML
    ;

/*Encontrar condiciones para el select*/
selectCondition: SELECT fieldsDML FROM identifier
    | selectCondition whereCondition
    ;

/*Encontrar condiciones en el where*/
whereCondition: WHERE identifier RELAC identifier
    | whereCondition LOGIC WHERE identifier RELAC identifier
    ;

/*detectar nombre del identificador*/
identifier: IDENT
    CONST
    ;

%%

int main(){
    prinf("Iniciando analisis sintactico...\n");

        yyparse();

    prinf("Iniciando analisis sintactico...\n");
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error sintactico: %s\n", s);
}