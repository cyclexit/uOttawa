% [odd|L] or [even|L] cannot be put on the condition.
oddEven([], []).
oddEven([E|Arr], [odd|L]) :-
  (E mod 2) =:= 1, !,
  oddEven(Arr, L).
oddEven([E|Arr], [even|L]) :-
  (E mod 2) =:= 0, !,
  oddEven(Arr, L).