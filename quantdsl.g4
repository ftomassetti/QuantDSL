grammar quantdsl;

/*
* Parser Rules
*/



contractDef : K_CONTRACT contractId K_IS instrumentDef K_END ';' 
    | K_CONTRACT contractId K_IS contractId K_AND contractId K_END ';' ;


instrumentDef : (optionDef|swapDef|cash);

swapDef : 'swapdef' /*todo*/;
cash : 'cashdef' /*todo*/;



optionDef : (K_CALL|K_PUT) K_OPTION K_WITH NEWLINE optionBody;

optionBody: /* todo: how to express this in any order? */
   '-' K_CURRENCY ':' currencyDef NEWLINE 
   '-' K_EXPIRY ':' DATE NEWLINE
   '-' K_UNDERLYING ':' instrumentCode NEWLINE
   '-' K_EXERCISE ':' (K_EUROPEAN|K_AMERICAN|K_BERMUDAN) NEWLINE
   ;




/*
 * Lexer Rules
*/

WHITESPACE : ' ' -> skip ;
NEWLINE : [\r\n] ;

contractId : [a-zA-Z]+[0-9a-zA-Z]*;
instrumentCode : [a-zA-Z]+[0-9a-zA-Z]*; /* for the moment parse same as ID. In the future this should be parsed as isin or valoren */ 

currencyDef : 'USD'|'CHF'|'EUR'|'GBP';  /* todo add more currencies */


/* make keywords case insensitive. Is this a good thing? */

K_CONTRACT : C O N T R A C T
K_AND : A N D
K_WITH : W I T H
K_OPTION : O P T I O N;
K_CALL : C A L L;
K_PUT : P U T;
K_WITH : W I T H;
K_END : E N D;
K_CURRENCY : C U R R E N C Y
K_EXPIRY : E X P I R Y;
K_UNDERLYING : U N D E R L Y I N G;



fragment A : [aA];
fragment B : [bB];
fragment C : [cC];
fragment D : [dD];
fragment E : [eE];
fragment F : [fF];
fragment G : [gG];
fragment H : [hH];
fragment I : [iI];
fragment J : [jJ];
fragment K : [kK];
fragment L : [lL];
fragment M : [mM];
fragment N : [nN];
fragment O : [oO];
fragment P : [pP];
fragment Q : [qQ];
fragment R : [rR];
fragment S : [sS];
fragment T : [tT];
fragment U : [uU];
fragment V : [vV];
fragment W : [wW];
fragment X : [xX];
fragment Y : [yY];
fragment Z : [zZ];




