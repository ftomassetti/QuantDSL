grammar quantdsl;

/*
 * Parser Rules
 */

quantProgram
    : statement* EOF
    ;

statement
    : contractDecl
    | contractDef
    ;

/* in our DSL a contract is a builtin type */
contractDecl 
    : IDENTIFIER (',' IDENTIFIER)* ':' 'contract' ';'
    ;


contractDef 
    : IDENTIFIER '=' instrumentDef ';'
    | IDENTIFIER '=' andExpression ';'
    ;


instrumentDef 
    : optionDef /* we only support options at the moment */
    ;

optionDef
    : 'option' parameter_clause
    ;

andExpression 
    : 'and' '('IDENTIFIER ',' IDENTIFIER ')'
    | IDENTIFIER 'and' IDENTIFIER
    ;

parameter_clause : '(' parameter_list ')' ;
parameter_list : (parameter (',' parameter)*)? ;
parameter
    : IDENTIFIER
    | DATE
    | CURRENCY
    | NUMBER
    | instrument_code
    | OPTION_TYPE
    | OPTION_STYLE
    ;

instrument_code 
    : REUTERS_RIC /* for the moment we support only reuters codes */
    ;  

/*
 * Lexer Rules
 */

LINE_COMMENT : '#' ~[\r\n]* -> skip ;
WHITESPACE : [ \t\r\n\u000C]+ -> skip ;

SLASH : '/' ;

// We enclose Reuters Rics between square brackets so we can recognize them from common identifiers
REUTERS_RIC : '[' [A-Z]+ '.' [A-Z]+ ']';
IDENTIFIER : [a-zA-Z]+[0-9a-zA-Z]*;

fragment DIGIT : [0-9] ;

NUMBER : DIGIT+ ('.' DIGIT+)? ;
DATE : DIGIT+ SLASH DIGIT+ SLASH DIGIT+;

CURRENCY
    :'USD'
    |'CHF'
    |'EUR'
    |'GBP'   /* todo add more currencies */
    ; 

OPTION_STYLE
    : 'european'
    | 'american'
    | 'bermudan'
    ;

OPTION_TYPE
    : 'call'
    | 'put'
    ;
