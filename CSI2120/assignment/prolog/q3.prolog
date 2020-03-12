choice(marie, [peru,greece,vietnam]).
choice(jean, [greece,peru,vietnam]).
choice(sasha, [vietnam,peru,greece]).
choice(helena,[peru,vietnam,greece]).
choice(emma, [greece,peru,vietnam]).

% getIndex function
getIndex(peru, I) :- I is 0.
getIndex(greece, I) :- I is 1.
getIndex(vietnam, I) :- I is 2.

% getCountry function
getCountry(0, Country) :- Country = peru.
getCountry(1, Country) :- Country = greece.
getCountry(2, Country) :- Country = vietnam.

% incWithIndex function
incWithIndex([H|T], 0, X, [HH|T]) :- HH is H + X, !.
incWithIndex([H|T], Index, X, [H|R]):- 
  Index > -1,
  NIndex is Index-1,
  incWithIndex(T, NIndex, X, R), !.

% incList function
incList([], Scores, _, Scores) :- !.
incList([C|Ranks], Scores, W, RScores) :-
  getIndex(C, Index),
  incWithIndex(Scores, Index, W, NScores),
  W1 is W - 1,
  incList(Ranks, NScores, W1, RScores).

% getMaxIndex function
getMaxIndex([X|_], Max, Cnt, Index) :-
  X == Max,
  Index is Cnt, !.
getMaxIndex([X|L], Max, Cnt, Index) :-
  X =\= Max,
  NCnt is Cnt + 1,
  getMaxIndex(L, Max, NCnt, Index).


% where function
where(Peoples, Country) :- 
  where(Peoples, [0, 0, 0], Country).
where([], Scores, Country) :-
  max_list(Scores, Max),
  getMaxIndex(Scores, Max, 0, Index),
  getCountry(Index, Country), !.
where([P|Peoples], Scores, Country) :-
  choice(P, Ranks),
  incList(Ranks, Scores, 3, NScores),
  where(Peoples, NScores, Country).