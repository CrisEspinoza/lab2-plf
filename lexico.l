
%option noyywrap
digito [0-9] 
letra [a-zA-Z]|\361|\321
identificador {letra}({letra}|{digito})*
numero {digito}+
palabra_reservada "const"|"var"|"procedure"|"call"|"begin"|"end"|"if"|"then"|"while"|"do"|"odd"
operador "<"|">"|"="|"+"|"-"|"/"|":="|"<="|">="|"#"|"*"
puntuacion "."|":"|","|";"|"("|")"
palabra {numero}|{identificador}|{operador}|{puntuacion}
nopalabra [^{palabra}]

%%
{operador} {fprintf(yyout,"%s\n",yytext);}
{puntuacion} {fprintf(yyout,"%s\n",yytext);}
{palabra_reservada} {fprintf(yyout,"%s\n",yytext);}
{identificador} {fprintf(yyout,"IDENTIFICADOR\n");}
{numero} {fprintf(yyout,"NUMERO\n");}
<<EOF>> {yyterminate();}
{nopalabra} {}
%%

int existeArchivo(char* nombre) 
{
    FILE* archivo = NULL;
    archivo = fopen(nombre,"r");
    if (archivo == NULL)
        return 0;
    else {
        fclose(archivo);
        return 1;
    }
    return 0;
}
int validarEntradas(int argc, char** argv)
{
    //Caso 1
    if (argc == 1)
    {
        printf("Error: Faltan par%cmetros en la l%cnea de comandos.\n",160,161);
        printf("Uso: lexico.exe archivo_entrada archivo_salida\n");
        return 0;
    }
    //Caso 2
    if (argc == 2)
    {
        printf("Error: Falta par%cmetro en la l%cnea de comandos.\n",160,161);
        printf("Uso: lexico.exe archivo_entrada archivo_salida\n");
        return 0;
    }
    //Caso 3 
    if( argc > 3 )
    {
        printf("Error: Demasiados par%cmetros en la l%cnea de comandos.\n",160,161);
        printf("Uso: lexico.exe archivo_entrada archivo_salida\n");
        return 0;
    }
    //Caso 4
    if (existeArchivo(argv[1]) == 0)
    {
        printf("Error: El archivo de entrada no existe.\n");
        return 0;
    }
    //Caso 5
    if (existeArchivo(argv[2]) == 1)
    {
        printf("Error: El archivo de salida ya existe.\n");
        return 0;
    }
    return 1;
}
int main(int argc, char** argv){
    if(!validarEntradas(argc,argv)){
        return 0;
    }
    yyin = fopen(argv[1],"r");
    yyout = fopen(argv[2], "w");
    yylex();
    return 1;
}