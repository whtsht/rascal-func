module Assembly

data Instr
    // Push integer constant on the stack
    = pushNat(int intCon)
    // Push identifier on the stack
    | pushId(str id)
    // Get the variable at identifier top-1 and push it on the stack
    | getVal()
    // Assign value on top, to variable at identifier top-1
    | setVal()
    // Associate a label with the next instruction
    | label(str label)
    // Jump to `label`
    | go(str label)
    // If the value at the top of the stack is non-zero, jump to `label`
    | goIf(str label)
    // Artithmetic Operators
    | mul() | div() | add() | sub()
    // Comparison Operators
    | gt() | lt() | ge() | le() | eq() | neq()
    // Call Function at identifier top-1
    | call()
    ;

alias Instrs = list[Instr];

alias Code = map[str, Instrs];