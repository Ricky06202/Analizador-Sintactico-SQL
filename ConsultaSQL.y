/*Aqui va los paquetes */
%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex();

%}

%locations

/*Aqui va los token para identificar cada palabra o cadena */
/* %token DLL TYPE DML CLAUS LOGIC TRANSACT RELAC CONST IDENT */

/*Data Definition Language*/
%token CREATE DROP ALTER TRUNCATE
/*Tipo de Estructura*/
%token TABLE SCHEMA DATABASE
/*Data Manipulation Language*/
%token SELECT INSERT DELETE UPDATE
/*Cláusulas*/
%token FROM SET WHERE GROUP ORDER ADD VALUES
/*Operadores*/
%token LOGIC ASC DESC
/*Tipos de datos, relaciones, constantes, identificadores y números*/
%token TRANSACT RELAC CONST IDENT NUM 
/*Comillas simples, parentesis, coma y punto y coma final de la instrucción*/
%token QUOTE ParentesisA ParentesisC COMMA SEMICOLON
//Comando para salir del programa
%token SALIR


%% /*Aqui va las instrucciones como si trabajaramos con GLC*/

/* Entrada de la consulta sql */
input: /* entrada vacia */
    | input consult         {printf("Consulta correcta. \n\n")}
    | input errorSintaxis   
    | input SALIR           {printf("Saliendo del programa. \n\n"); exit(0)}
    ;

/*Consultas*/
consult: commandDLL SEMICOLON       
    | commandDML SEMICOLON      
    ;

errorSintaxis: commandDLL           {printf("La consulta debe terminar con ; \n\n")}
    | commandDML                    {printf("La consulta debe terminar con ; \n\n")}
    | selectError                   {printf("Primero debe ir una instrucción \n\n")}
    | errorParentesis
    | errorNames                    {printf("Se debe escribir el identificador al hacer referencia \n\n")}
    ;

/*Comandos para CREATE, DROP, ALTER y TRUNCATE*/
commandDLL: createCondition
    | DROP TABLE identifier 
    | ALTER TABLE identifier ADD identifier TRANSACT ParentesisA NUM ParentesisC 
    | TRUNCATE TABLE identifier 
    ;

/*Comandos con CREATE*/
createCondition: CREATE TABLE identifier ParentesisA fieldsCreate ParentesisC 
    | CREATE SCHEMA identifier 
    | CREATE DATABASE identifier
    ;

/*Comandos para INSERT SELECT UPDATE y DELETE*/
commandDML: selectCondition 
    | INSERT identifier ParentesisA fieldsDML ParentesisC VALUES ParentesisA fieldsDML ParentesisC
    | INSERT identifier VALUES ParentesisA fieldsDML ParentesisC
    | UPDATE identifier setCondition
    | DELETE FROM identifier whereCondition 
    ;
/*Encontrar condiciones para el select*/
selectCondition: SELECT fieldsDML FROM identifier
    | selectCondition whereCondition
    | selectCondition groupCondition
    | selectCondition orderCondition
    ;

/*Encontrar condiciones en el where*/
whereCondition: WHERE identifier RELAC QUOTE identifier QUOTE
    | WHERE identifier RELAC NUM
    | whereCondition LOGIC identifier RELAC QUOTE identifier QUOTE
    | whereCondition LOGIC identifier RELAC NUM
    ;

/*Encontrar condiciones en el where*/
setCondition: SET identifier RELAC QUOTE identifier QUOTE
    | setCondition COMMA identifier RELAC QUOTE identifier QUOTE
    ;

/*Condiciones para GROUP BY*/
groupCondition: GROUP identifier
    ;

/*Condiciones para ORDER BY*/
orderCondition: ORDER identifier ASC
    | ORDER identifier DESC
    ;

/*Campos de la tabla */
/* fieldsDLL: identifier TRANSACT ParentesisA NUM ParentesisC
    | fieldsDLL COMMA identifier TRANSACT ParentesisA NUM ParentesisC
    ; */

/*Campos para crear tabla*/
fieldsCreate: identifier TRANSACT
    | fieldsCreate COMMA identifier TRANSACT
    ;

/*Campos de los datos */
fieldsDML: identifier
    | fieldsDML COMMA identifier
    ;

/*detectar nombre del identificador*/
identifier: IDENT
    | CONST
    ;

/*---------------------------------------------------------------------------*/
/*Detectar errores en el orden de la consulta*/
selectError: fieldsDML SELECT FROM identifier
    | selectError whereCondition
    ;

errorParentesis: INSERT identifier ParentesisA fieldsDML VALUES ParentesisA fieldsDML ParentesisC  {printf("Parentesis debe cerrarse \n\n")}
    | INSERT identifier ParentesisA fieldsDML ParentesisC VALUES ParentesisA fieldsDML             {printf("Parentesis debe cerrarse \n\n")}
    | INSERT identifier VALUES fieldsDML ParentesisC                    {printf("Parentesis debe abrirse ante de cerrarse \n\n")}
    | INSERT identifier VALUES ParentesisA fieldsDML                    {printf("Parentesis debe cerrarse \n\n")}
    | identifier TRANSACT NUM ParentesisC                               {printf("Parentesis debe abrirse ante de cerrarse \n\n")}
    | identifier TRANSACT ParentesisA NUM                               {printf("Parentesis debe cerrarse \n\n")}
    | CREATE TABLE identifier ParentesisA fieldsCreate                  {printf("Parentesis debe cerrarse \n\n")}
    | CREATE TABLE identifier fieldsCreate ParentesisC                  {printf("Parentesis debe abrirse ante de cerrarse \n\n")}
    | ALTER TABLE identifier ADD identifier TRANSACT ParentesisA NUM    {printf("Parentesis debe cerrarse \n\n")}
    | ALTER TABLE identifier ADD identifier TRANSACT NUM ParentesisC    {printf("Parentesis debe abrirse ante de cerrarse \n\n")}
    ;

errorNames: CREATE TABLE ParentesisA fieldsCreate ParentesisC 
    | DROP TABLE  
    | ALTER TABLE ADD identifier TRANSACT ParentesisA NUM ParentesisC 
    | ALTER TABLE identifier ADD TRANSACT ParentesisA NUM ParentesisC 
    | TRUNCATE TABLE  
    | INSERT ParentesisA fieldsDML ParentesisC VALUES ParentesisA fieldsDML ParentesisC
    | INSERT VALUES ParentesisA fieldsDML ParentesisC
    | UPDATE setCondition
    | DELETE FROM  whereCondition 
    ;

%%

int main(){
    printf("Ingresar una consulta para SQL: \n");
    yyparse();
    return 0;
}

void yyerror(const char *s) {
    fprintf(stderr, " %s: sentencia invalida \nVerifique que se escribio correctamente los comandos en el orden indicado\n\n", s);
}

