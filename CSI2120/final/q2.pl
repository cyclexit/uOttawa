% database info
weekends(march, 2020, [-4, 1, 6, 4,-2,-4, 0, 7, 8], [-1, 0, 0, 2, 2, 4, 4, 6 ,6]).

% part a): difference/3 predicate
difference([], [], []).
difference([A|L1], [B|L2], [Diff|D]) :-
  Diff is A - B,
  difference(L1, L2, D).

% part b): positive/2 predicate
positive([], 0).
positive([A|L], N) :-
  A > 0,
  positive(L, NN), !,
  N is NN + 1.
positive([A|L], N) :-
  A =< 0,
  positive(L, N), !.

% part c): niceMonth/2 predicate
niceMonth(Month, Year) :-
  weekends(Month, Year, Observed, Normal),
  difference(Observed, Normal, Diff),
  length(Observed, Len),
  positive(Diff, Num),
  Num > Len / 2.