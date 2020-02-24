addSecond([], 0).
addSecond([_], 0) :- true, !.
addSecond([I1, I2|A], S) :-
  addSecond(A, SS),
  S is SS + I2, !.