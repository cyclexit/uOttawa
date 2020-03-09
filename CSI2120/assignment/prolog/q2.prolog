% adjacency
adj(a,b).
adj(a,g).
adj(b,c).
adj(b,i).
adj(c,d).
adj(d,e).
adj(d,j).
adj(e,l).
adj(f,g).
adj(g,h).
adj(h,i).
adj(i,j).
adj(j,k).
adj(k,l).
adj(l,m).

% color
color(red).
color(yellow).
color(blue).

% color set
colorset([], []).
colorset([_|L], [X|C]) :-
  color(X),
  colorset(L, C).

% adjacenct parts should have different color
% ?: after 'true', there is a 'false'
diffadjcolor(_, _, [], []).
diffadjcolor(G, C, [XG|Gs], [XC|Cs]) :-
  adj(G, XG),
  C \= XC,
  diffadjcolor(G, C, Gs, Cs).
diffadjcolor(G, C, [XG|Gs], [_|Cs]) :- 
  \+adj(G, XG),
  diffadjcolor(G, C, Gs, Cs).

% check whether the color set is valid
valid([], []).
valid([XG|Gs], [XC|Cs]) :- 
  diffadjcolor(XG, XC, Gs, Cs),
  valid(Gs, Cs).

% generator
generate(Gs, Cs) :- colorset(Gs, Cs), valid(Gs, Cs).