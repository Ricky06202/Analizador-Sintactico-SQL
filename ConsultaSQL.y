/*Aqui va los paquetes */
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();

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
/*Tipos de datos, relaciones, constantes, identificadores, números y punto y coma final de la declaración*/
%token TRANSACT RELAC CONST IDENT NUM ParentesisA ParentesisC COMMA SEMICOLON


%% /*Aqui va las instrucciones como si trabajaramos con GLC*/

/* Entrada de la consulta sql */
input: /* entrada vacia */
    | input consult {printf("Consulta correcta. \n")}
    | input 'salir' {printf("Saliendo del programa. \n"); exit(0)}
    ;

/*Consultas*/
consult: commandDLL
    | commandDML
    /* | DROP identifier SEMICOLON */
    ;

/*Comandos para CREATE, DROP, ALTER y TRUNCATE*/
commandDLL: CREATE TABLE identifier ParentesisA fieldsDLL ParentesisC SEMICOLON
    | DROP TABLE identifier SEMICOLON
    | ALTER TABLE identifier ADD identifier TRANSACT ParentesisA NUM ParentesisC SEMICOLON
    | TRUNCATE TABLE identifier SEMICOLON
    ;

/*Comandos para INSERT SELECT UPDATE y DELETE*/
commandDML: selectCondition SEMICOLON
    | INSERT identifier ParentesisA fieldsDML ParentesisC VALUES ParentesisA fieldsDML ParentesisC SEMICOLON
    | UPDATE identifier SET whereCondition SEMICOLON
    | DELETE FROM identifier whereCondition SEMICOLON
    ;
/*Encontrar condiciones para el select*/
selectCondition: SELECT fieldsDML FROM identifier
    | selectCondition whereCondition
    ;

/*Encontrar condiciones en el where*/
whereCondition: WHERE identifier RELAC identifier
    | whereCondition LOGIC identifier RELAC identifier
    ;

/*Campos de la tabla */
fieldsDLL: identifier TRANSACT ParentesisA NUM ParentesisC
    | fieldsDLL COMMA identifier TRANSACT ParentesisA NUM ParentesisC
    ;

/*Campos de los datos */
fieldsDML: identifier
    | fieldsDML COMMA identifier
    ;

/*detectar nombre del identificador*/
identifier: IDENT
    | CONST
    ;

%%

int main(){
    printf("Iniciando analisis sintactico...\n");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, "Error sintactico: %s\n", s);
}