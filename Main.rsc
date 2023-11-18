module Main

import Load;
import Compile;
import Assembly;

Code compile(str s) = compileProg(load(s));
Code compile(loc l) = compileProg(load(l));