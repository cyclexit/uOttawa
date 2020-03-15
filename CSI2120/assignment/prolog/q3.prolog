choice(marie, [peru,greece,vietnam]).
choice(jean, [greece,peru,vietnam]).
choice(sasha, [vietnam,peru,greece]).
choice(helena,[peru,vietnam,greece]).
choice(emma, [greece,peru,vietnam]).

% update1 function
update1([], _, _, _, []) :- !.
update1([C|Ranks], W, Keys, Pairs, [C-W|NPairs]) :-
  \+member(C, Keys),
  W1 is W - 1,
  update1(Ranks, W1, Keys, Pairs, NPairs), !.
update1([C|Ranks], W, Keys, Pairs, [C-NVal|NPairs]) :-
  member(C, Keys),
  NVal is Pairs.C+W,
  W1 is W - 1,
  update1(Ranks, W1, Keys, Pairs, NPairs), !.

% update2 function
update2([], _, NPairs, NPairs) :- !.
update2([K|DKeys], Pairs, NPairs, [K-Pairs.K|NNPairs]) :-
  update2(DKeys, Pairs, NPairs, NNPairs).

% getAns function
getAns(_, [], []) :- !.
getAns(Max, [C-P|Pairs], [C|Country]) :-
  P =:= Max,
  getAns(Max, Pairs, Country), !.
getAns(Max, [_-P|Pairs], Country) :-
  P =\= Max,
  getAns(Max, Pairs, Country), !.

% printAns function
printAns([]).
printAns([C|Country]) :-
  writeln(C),
  printAns(Country).

% where function
where(People, Country) :- 
  where(People, [], Country).
where([], Pairs, Country) :-
  pairs_values(Pairs, Vals),
  max_member(Max, Vals),
  getAns(Max, Pairs, Country),
  printAns(Country).
where([P|People], Pairs, Country) :-
  choice(P, Ranks),
  pairs_keys(Pairs, Keys),
  update1(Ranks, 3, Keys, Pairs, NPairs), % update1
  pairs_keys(NPairs, NKeys),
  subtract(Keys, NKeys, DKeys),
  update2(DKeys, Pairs, NPairs, NNPairs), % update2
  where(People, NNPairs, Country).