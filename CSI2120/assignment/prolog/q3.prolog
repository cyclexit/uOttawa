choice(marie, [peru,greece,vietnam]).
choice(jean, [greece,peru,vietnam]).
choice(sasha, [vietnam,peru,greece]).
choice(helena,[peru,vietnam,greece]).
choice(emma, [greece,peru,vietnam]).

% update function
update([], _, _, []).
update([C|Ranks], W, Pairs, [C-W|NPairs]) :-
  pairs_keys(Pairs, Keys),
  \+member(C, Keys),
  W1 is W - 1,
  update(Ranks, W1, Pairs, NPairs).
update([C|Ranks], W, Pairs, [C-NVal|NPairs]) :-
  pairs_keys(Pairs, Keys),
  member(C, Keys),
  NVal is Pairs.C+W,
  W1 is W - 1,
  update(Ranks, W1, Pairs, NPairs).

% where function
where(People, Country) :- 
  where(People, [], Country).
where([], _, _). % TODO
where([P|People], Pairs, Country) :-
  choice(P, Ranks),
  update(Ranks, 3, Pairs, NPairs),
  where(People, NPairs, Country).