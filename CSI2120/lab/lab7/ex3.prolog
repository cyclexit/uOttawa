%reverseDrop(L, R) :- reverseDrop(L, 1, [], R), !.
%reverseDrop([], _, R, R) :- !.
%reverseDrop([HL|TL], 1, I, R) :-
%  reverseDrop(TL, 0, [HL|I], R).
%reverseDrop([_|TL], 0, I, R) :-
%  reverseDrop(TL, 1, I, R).

reverseDrop(List, Res) :- reverseDrop(List, [], Res). % Use an auxilary to keep variable
reverseDrop([], Res, Res) :- !. % Assign the auxilary array to the result, and cut.
reverseDrop([A, _|Arr], L, Res) :-
  reverseDrop(Arr, [A|L], Res).