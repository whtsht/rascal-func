module Abstract

data BINDING
    = binding(str name, EXP exp);

data EXP
    = natCon(int iVal)
    | mul(EXP e1, EXP e2)
    | div(EXP e1, EXP e2)
    | sub(EXP e1, EXP e2)
    | add(EXP e1, EXP e2)
    | gt(EXP e1, EXP e2)
    | lt(EXP e1, EXP e2)
    | ge(EXP e1, EXP e2)
    | le(EXP e1, EXP e2)
    | eq(EXP e1, EXP e2)
    | neq(EXP e1, EXP e2)
    | id(str name)
    | let(list[BINDING] binds, EXP exp)
    | cond(EXP condExp, EXP thenExp, EXP elseExp)
    | call(str name, list[EXP] args)
    ;

data FUNC
    = func(str name, list[str] args, EXP exp);

data PROG
    = prog(list[FUNC] funcs);