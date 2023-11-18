module Compile

import Assembly;
import Abstract;
import IO;

Instrs compileBinding(binding(str name, EXP exp))
    = [pushId(name), *compileExp(exp), setVal()];

Instrs compileExp(natCon (int N)) = [pushNat(N)];

Instrs compileExp(id (str name)) = [pushId(name), getVal()];

Instrs compileExp(let (list[BINDING] binds, EXP exp))
    = [*([*compileBinding(bind) | bind <- binds]), *compileExp(exp)];

private int nLabel = 0;

private str nextLabel() {
  nLabel += 1;
  return "L<nLabel>";
}

Instrs compileExp(cond(EXP condExp, EXP thenExp, EXP elseExp)) {
    thenLabel = nextLabel();
    endLabel = nextLabel();
    return [
        *compileExp(condExp),
        goIf(thenLabel),
        *compileExp(elseExp),
        go(endLabel),
        label(thenLabel),
        *compileExp(thenExp),
        label(endLabel)
    ];
}

Instrs compileExp(mul(EXP e1, EXP e2)) = [*compileExp(e1), *compileExp(e2), mul()];
Instrs compileExp(div(EXP e1, EXP e2)) = [*compileExp(e1), *compileExp(e2), div()];
Instrs compileExp(sub(EXP e1, EXP e2)) = [*compileExp(e1), *compileExp(e2), sub()];
Instrs compileExp(add(EXP e1, EXP e2)) = [*compileExp(e1), *compileExp(e2), add()];
Instrs compileExp(gt(EXP e1, EXP e2)) = [*compileExp(e1), *compileExp(e2), gt()];
Instrs compileExp(lt(EXP e1, EXP e2)) = [*compileExp(e1), *compileExp(e2), lt()];
Instrs compileExp(ge(EXP e1, EXP e2)) = [*compileExp(e1), *compileExp(e2), ge()];
Instrs compileExp(le(EXP e1, EXP e2)) = [*compileExp(e1), *compileExp(e2), le()];
Instrs compileExp(eq(EXP e1, EXP e2)) = [*compileExp(e1), *compileExp(e2), eq()];
Instrs compileExp(neq(EXP e1, EXP e2)) = [*compileExp(e1), *compileExp(e2), neq()];

Instrs compileExp(call(str name, list[EXP] args))
    = [*[*compileExp(arg) | arg <- args], pushId(name), call()];

Instrs compileFunc(list[str] args, EXP exp)
    = [*[*[pushId(arg), setVal()] | arg <- args], *compileExp(exp)];

Code compileProg(prog (list[FUNC] funcs))
    = (name : compileFunc(args, exp)
        | func(str name, list[str] args, EXP exp) <- funcs);
