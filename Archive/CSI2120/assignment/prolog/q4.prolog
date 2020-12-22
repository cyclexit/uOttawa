% divisible function
divisible([], _) :- fail.
divisible([X|_], Num) :-
  M is mod(Num, X),
  M =:= 0, !.
divisible([X|Nums], Num) :-
  M is mod(Num, X),
  M =\= 0,
  divisible(Nums, Num), !.

% solve function
solve(_, Len, Index, _, []) :-
  Index =:= Len + 1.
solve(Nums, Len, Index, Val, [Val|L]) :-
  Index =< Len,
  Val =< Index,
  \+divisible(Nums, Val),
  NIndex is Index + 1,
  solve(Nums, Len, NIndex, 1, L).
solve(Nums, Len, Index, Val, L) :-
  Index =< Len,
  Val =< Index,
  NVal is Val + 1,
  solve(Nums, Len, Index, NVal, L).

% generateList function
generateList(Nums, Len, L) :-
  solve(Nums, Len, 1, 1, L).