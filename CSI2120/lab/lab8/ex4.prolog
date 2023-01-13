sumNodes(T, L) :- sumNodes(T, [], L, 0).
sumNodes(nil, L, L, _) :- !.
sumNodes(t(Root, Left, Right), T, L, X) :- 
  Cur is Root + X,
  sumNodes(Left, T, LL, Cur),
  sumNodes(Right, T, LR, Cur),
  append(LL, [Cur|LR], L).