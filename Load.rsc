module Load

import Prelude;
import Syntax;
import Abstract;

PROG load(str s) = implode(#PROG, parse(#start[Prog], s).top);
PROG load(loc l) = implode(#PROG, parse(#start[Prog], l).top);