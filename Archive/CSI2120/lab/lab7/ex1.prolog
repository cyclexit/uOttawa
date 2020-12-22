max(A, B, A) :- A > B, !.
max(A, B, B) :- A =< B, !.

min(A, B, A) :- A < B, !.
min(A, B, A) :- A >= B, !.

maxmin([E|Arr], Max, Min) :-
  length(Arr, Len),
  Len is 0,
  Max is E,
  Min is E.
maxmin([E|Arr], Max, Min) :-
  maxmin(Arr, Mx, Mn),
  max(E, Mx, Max),
  min(E, Mn, Min), !.