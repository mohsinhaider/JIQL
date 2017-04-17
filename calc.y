/* Definition Section: */
%{
	void yyerror (char *s);
	#include <stdio.h>     /* C declarations used in actions */
	#include <stdlib.h>
	#include <stdbool.h>
%}

%union {int num; char id[35]; float dec; char stream[100]; bool bval;}
%start line
%token <stream> word
%token <dec> float
%token <num> integer
%token <id> identifier
%type <num> line exp term
%type <id> assignment 
%type <dec> dexp
%type <bval> bexp

%%
/* Rules Section */

line    : assignment ';'{;}
        | exit_command ';'{exit(EXIT_SUCCESS);}
        | print exp ';'{printf("Printing %d\n", $2);}
        | line assignment ';'{;}
        | line print exp ';'{printf("Printing %d\n", $3);}
        | line exit_command ';'{exit(EXIT_SUCCESS);}
;

assignment : identifier '=' dexp  { updateSymbolVal($1,$3); }
		   | identifier '=' bexp { updateSybmolVal($1,$3); }
;

dexp    : term                  {$$ = $1;}
       | dexp '+' term          {$$ = $1 + $3;}
       | dexp '-' term          {$$ = $1 - $3;}
;

bexp    : term                  {$$ = $1;}
       | bexp '+' term          {$$ = $1 + $3;}
       | bexp '-' term          {$$ = $1 - $3;}
;

term   : number                {$$ = $1;}
       | identifier{$$ = symbolVal($1);} 
;


%%
/* Code Section */

void yyerror (char *s) {fprintf (stderr, "%s\n", s);} 

