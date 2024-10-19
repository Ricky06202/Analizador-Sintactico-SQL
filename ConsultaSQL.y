%{
    #include <stdio.h>
#include <string.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);


%}

%token DLL
%token TYPE
%token DML
%token CLAUS
%token LOGIC
%token TRANSACT
%token RELAC
%token CONST
%token IDENT
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
commandDLL: DLL TYPE IDENT
    | commandDLL '(' fieldsDLL ')'
    ;

/*Comandos para INSERT SELECT UPDATE y DELETE*/
commandDML: DML identifier CLAUS identifier
    | commandDML CLAUS identifier
    | commandDML '(' fieldsDML ')' "VALUES" '(' fieldsDML ')'
    ;

/*campos de la tabla */
fieldsDLL: identifier identifier '(' CONST ')'
    | "," fieldsDLL
    ;

fieldsDML: identifier
    | "," fieldsDML
    ;

/*detectar nombre del identificador*/
identifier: IDENT
    | CONST
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