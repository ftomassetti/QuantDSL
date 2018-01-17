grammar quantdsl;

/*
* Parser Rules
*/



start
    : statement+
    ;

statement
    : contractDecl
    | contractDef
    ;


/* in our DSL a contract is a builtin type */
contractDecl 
    : Identifier (',' Identifier)* ':' 'contract' ';' 
    ;


contractDef 
    : Identifier '=' instrumentDef ';'
    | Identifier '=' andExpression ';' 
    ;


instrumentDef 
    : optionDef /* we only support options at the moment */
    ;

optionDef
    : 'option' parameter_clause
    ;

andExpression 
    : 'and' '('Identifier ',' Identifier ')' ';'
    | Identifier 'and' Identifier ';'
    ;


parameter_clause : '(' parameter_list ')' ;
parameter_list : parameter (',' parameter)* ;
parameter
    : Identifier
    | date
    | currency
    | instrument_code
    | option_type
    | option_style
    ;

option_style
    : 'european'
    | 'american'
    | 'bermudan'
    ;

option_type
    : 'call'
    | 'put'
    ;


instrument_code 
    : ReutersRic /* for the moment we support only reuters codes */ 
    ;  


/*
 * Lexer Rules
*/

WHITESPACE : ' ' -> skip ;
SLASH : '/' ;
DIGIT : [0-9] ;
two_digit: DIGIT DIGIT;
four_digit :  DIGIT DIGIT DIGIT DIGIT;
date : two_digit SLASH two_digit SLASH four_digit;

ReutersRIC : [A-Z]{1,4}'.'[A-Z]{1,2}; 
Identifier : [a-zA-Z]+[0-9a-zA-Z]*;

currency 
    : 'USD'
    |'CHF'
    |'EUR'
    |'GBP'   /* todo add more currencies */
    ; 

