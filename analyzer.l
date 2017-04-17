/* Definition Section */
%{
    #include <stdlib.h>
    #include <math.h>
    void yyerror(char *);
    int num_chars = 0;
    int num_lines = 0;
    int num_strings = 0;
%}

INTEGER   \-?[0-9]+
FLOAT     \-?[0-9]+\.[0-9]+
ID       [a-z][a-z0-9]*
STRING   \"[a-z]*[a-z0-9]*\"
BOOLEAN  ("true"|"false")

%%

"print"    {return print;}
"exit"     {return exit_command;}
            
{STRING} {printf("A string: %s\n", yytext); }


{INTEGER}+    { printf( "An integer: %s (%d)\n", yytext, atoi( yytext ) ); }

{FLOAT}   { printf("A float: %s\n", yytext); }

{BOOLEAN}  {printf("A boolean: %s\n", yytext);}

"-"  { printf("A minus: %s\n", yytext); }
"("  { printf("A left paren: %s\n", yytext); }
")"  { printf("A right paren: %s\n", yytext); }
"<"  { printf("A less than sign: %s\n", yytext); }
">"  { printf("A greater than sign: %s\n", yytext); }
"="  { printf("An equal sign: %s\n", yytext); }
"+"  { printf("A plus sign: %s\n", yytext); }
"*"  { printf("A multiply sign: %s\n", yytext); }
"/"  { printf("A divison sign: %s\n", yytext); }
";"  { printf("A semicolon: %s\n", yytext); }
"{"  { printf("A left bracket: %s\n", yytext); }
"}"  { printf("A right bracket: %s\n", yytext); }
">=" { printf("A right bracket: %s\n", yytext); }
"<=" { printf("A right bracket: %s\n", yytext); }
"==" { printf("A right bracket: %s\n", yytext); }
"!=" { printf("A right bracket: %s\n", yytext); }
"while" { printf("A right bracket: %s\n", yytext); }
"if"  { printf("A right bracket: %s\n", yytext); }
"else" { printf("A right bracket: %s\n", yytext); }
"print"  { printf("A right bracket: %s\n", yytext); }


[ \t\n]+          /* eat up whitespace */

.           printf( "Unrecognized character: %s\n", yytext );




%%


int main( argc, argv )
int argc;
char **argv;
    {
    ++argv, --argc;  /* skip over program name */
    if ( argc > 0 )
            yyin = fopen( argv[0], "r" );
    else
            yyin = stdin;

    yylex();
    }
