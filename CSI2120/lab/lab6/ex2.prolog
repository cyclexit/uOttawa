element(chlorine,'Cl').
element(helium,'He').
element(hydrogen,'H').
element(nitrogen,'N').
element(oxygen,'O').

lookUp(X) :-
  element(Y, X),
  write(X), write(" is the symbol for: "), writeln(Y).

lookUp(X) :-
  write("Don't know the symbol: "), writeln(X), !, fail.

elements :- 
  writeln("Elements in the Periodic Table"),
  repeat,
  writeln("Symbol to look-up:"),
  read(X),
  not(lookUp(X)),
  writeln('Exiting.'), !, fail.