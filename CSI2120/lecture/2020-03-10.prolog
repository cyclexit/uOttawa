% graph
% g([node, ...], [edge(u,v,w), ...]).

% Directed
edge(g(Ns, Edges), N1, N2, W) :- member(edge(N1, N2, W), Edges).

% Undirected
edge(g(Ns, Edges), N1, N2, W) :- member(edge(N1, N2, W), Edges); member(edge(N2, N1, W), Edges).

% neighbour function
neighbour(Graph, Node, NBs) :- setof((N, Edge), edge(Graph, Node, N, Edge), NBs).

% graph A
graphA(X) :- 
  X = g(
    [a,b,c,d,e,f],
    [edge(a,b,3),edge(a,c,5),edge(a,d,7),edge(e,f,1),edge(d,f,6)]
  ).