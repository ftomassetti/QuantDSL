grammar quantdsl;

/*
* Parser Rules
*/


parse
 : (contractDef)* EOF
 ;

contractDecl 
    : Identifier (',' Identifier)* ':' 'contract' ';' 
    ;


contractDef 
    : Identifier '=' instrumentDef ';' 
    ;

instrumentDef 
    : (optionDef|swapDef|cash)
    ;

swapDef 
    : 'swapdef' /*todo*/
    ;

cash 
    : 'cashdef' /*todo*/
    ;


optionDef : 'option' '(' K_CALL|K_PUT ','  






optionDef : (K_CALL|K_PUT) K_OPTION K_WITH NEWLINE optionBody;

optionBody: /* todo: how to express this in any order? */
   '-' K_CURRENCY ':' currencyDef NEWLINE 
   '-' K_EXPIRY ':' date NEWLINE
   '-' K_UNDERLYING ':' instrumentCode NEWLINE
   '-' K_EXERCISE ':' (K_EUROPEAN|K_AMERICAN|K_BERMUDAN) NEWLINE
   ;


/*
 * Lexer Rules
*/

WHITESPACE : ' ' -> skip ;
NEWLINE : [\r\n] ;
SLASH : '/'
DIGIT : [0-9] ;
two_digit: digit digit;
four_digit :  digit digit digit digit;
date : two_digit SLASH two_digit SLASH four_digit

Identifier : [a-zA-Z]+[0-9a-zA-Z]*;
instrumentCode : [a-zA-Z]+[0-9a-zA-Z]*; /* for the moment parse same as ID. In the future this should be parsed as isin or valoren */ 

currencyDef : 'USD'|'CHF'|'EUR'|'GBP';  /* todo add more currencies */



K_COLON : ':';
K_SEMICOLON : ';'

K_CONTRACT : 'contract';
K_AND : 'and'
K_OPTION : 'option';
K_CALL : 'call';
K_PUT : 'put';
K_CURRENCY : 'currency'
K_EXPIRY : 'expiry';
K_UNDERLYING : 'underlying';
K_EUROPEAN : 'european';
K_AMERICAN : 'american';
K_BERMUDAN : 'bermudan';



