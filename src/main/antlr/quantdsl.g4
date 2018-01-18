grammar quantdsl;

/*
* Parser Rules
*/

file : (contract_decl|stat)+
    ;



/* in our DSL a contract is a builtin type */
contract_decl 
    : contract_type identifier ('=' instrument_initializer) ';'
    ;

contract_type
    : 'option'
    | 'swap'
    | 'bond'
    ;


instrument_initializer
    : option_initializer
    | swap_initializer
    ;

option_initializer
    : 'option' '(' option_type ',' date ',' reuters_ric ',' number ',' currency ',' option_style ')' 
    ;

swap_initializer
    : 'swap'
    ;

stat
    : identifier '=' instrument_initializer ';'
    | identifier '=' identifier ';'
    | identifier '=' and_expr ';'
    | price_stat ';'
    ;


and_expr
    : 'and' '('Identifier ',' Identifier ')' ';'
    | Identifier 'and' Identifier ';'
    ;

price_stat
    : 'price' '(' Identifier ')' + ';'
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

ReutersRIC : [A-Z]([A-Z]([A-Z]([A-Z])?)?)?'.'[A-Z]([A-Z])?;
identifier : [a-zA-Z]+[0-9a-zA-Z]*;

currency 
    : 'USD'
    |'CHF'
    |'EUR'
    |'GBP'   /* todo add more currencies */
    ; 

