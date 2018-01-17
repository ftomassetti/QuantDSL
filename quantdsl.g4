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
    ;


instrumentDef 
    : optionDef /* we only support options at the moment */
    ;

optionDef
    : 'option' parameter_clause
    ;

andOperator : 'and' '('identifier ',' identifier ')' ';'



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
SLASH : '/'
DIGIT : [0-9] ;
two_digit: digit digit;
four_digit :  digit digit digit digit;
date : two_digit SLASH two_digit SLASH four_digit

ReutersRIC : [A-Z]{1,4}\.[A-Z]{1,2}; 
Identifier : [a-zA-Z]+[0-9a-zA-Z]*;

currency 
    : 'USD'
    |'CHF'
    |'EUR'
    |'GBP'   /* todo add more currencies */
    ; 



K_CALL : 'call';
K_PUT : 'put';
K_CURRENCY : 'currency'
K_EXPIRY : 'expiry';
K_UNDERLYING : 'underlying';
K_EUROPEAN : 'european';
K_AMERICAN : 'american';
K_BERMUDAN : 'bermudan';



