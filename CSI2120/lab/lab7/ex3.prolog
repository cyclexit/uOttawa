reverseDrop(L, R) :- reverseDrop(L, 2, [], R), !.
reverseDrop([], _,R, R) :- !.
reverseDrop([HL|TL], N, I, R) :-
  N = 1,
  reverseDrop(TL, 0, [H|I], R).
reverseDrop([_|TL], N, I, R) :-
  N = 0,
  reverseDrop(TL, 1, I, R).
