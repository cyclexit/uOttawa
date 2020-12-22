secondLast(X, [A|B]) :- 
  length(B, 1),
  X is A, !.

secondLast(X, [_|B]) :-
  length(B, LEN),
  LEN > 1,
  secondLast(X, B).