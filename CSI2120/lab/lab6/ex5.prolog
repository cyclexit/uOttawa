addSecond([], 0).
addSecond([_], 0) :- true, !.
addSecond([_, I2|A], S) :-
  addSecond(A, SS),
  S is SS + I2, !.