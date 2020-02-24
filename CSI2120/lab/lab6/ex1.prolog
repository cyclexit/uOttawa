% countDown(N) :- repeat, writeln(N), N is N-1, N<0, !.
% "N is N-1" is always false, so N will not count down.

countDown(N) :- N >= 0, writeln(N), NN is N-1, countDown(NN).