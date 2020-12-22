% part a)
numOccur(_, [], 0) :- !.
numOccur(E, [E|L], R) :-
  numOccur(E, L, RR), !,
  R is RR + 1.
numOccur(E, [_|L], R) :-
  numOccur(E, L, R).

% part b)
flip([], Temp, Temp) :- !.
flip([(A, B)|IL], Temp, OL) :-
  flip(IL, [(B, A)|Temp], OL).
flip(IL, OL) :- flip(IL, [], OL).