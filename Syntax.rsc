module Syntax

lexical Ident = [a-z][a-z0-9]* !>> [a-z0-9];

lexical Natural = [0-9]+ ;

lexical String = "\"" ![\"]*  "\"";

layout Layout = WhitespaceAndComment* !>> [\ \t\n\r];

lexical WhitespaceAndComment
   = [\ \t\n\r]
   | @category="Comment" ws2: "%" ![%]+ "%"
   | @category="Comment" ws3: "%%" ![\n]* $
   ;

syntax Binding = binding: Ident name "=" Exp exp;

syntax Exp
    = natCon: Natural
    | bracket "(" Exp ")"
    > left (mul: Exp e1 "*" Exp e2 | div: Exp e1 "/" Exp e2)
    > left (sub: Exp e1 "-" Exp e2 | add: Exp e1 "+" Exp e2)
    > left ( gt: Exp e1 "\>" Exp e2
           | lt: Exp e1 "\<" Exp e2
           | ge: Exp e1 "\>=" Exp e2
           | le: Exp e1 "\<=" Exp e2
           )
    > left (eq: Exp e1 "==" Exp e2 | neq: Exp e1 "/=" Exp e2)
    | id: Ident name
    | let: "let" {Binding ","}* binds "in" Exp exp "end"
    | cond: "if" Exp condExp "then" Exp thenExp "else" Exp elseExp "end"
    | call: Ident name "(" {Exp ","}* args ")"
    ;

syntax Func = func: Ident name "(" {Ident ","}* args ")" "=" Exp;

start syntax Prog = prog: Func*;