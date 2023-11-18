# Func

A toy language compiler made with Rascal.

## Examples

```
$ rascal
rascal>import Main;
rascal>compile(|cwd:///examples/fib.func|);
map[str, list[Instr]]: ("fib":[
    pushId("n"),
    setVal(),
    pushId("n"),
    getVal(),
    pushNat(2),
    lt(),
    goIf("L1"),
    pushId("n"),
    getVal(),
    pushNat(1),
    sub(),
    pushId("fib"),
    call(),
    pushId("n"),
    getVal(),
    pushNat(2),
    sub(),
    pushId("fib"),
    call(),
    add(),
    go("L2"),
    label("L1"),
    pushId("n"),
    getVal(),
    label("L2")
  ])
```
