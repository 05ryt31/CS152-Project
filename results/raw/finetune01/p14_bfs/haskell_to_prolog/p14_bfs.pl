bfs(Graph, Start, Goal, Path):-
	bfs([[Start]], Graph, Goal, Path).
 
bfs([[Goal]|_], _, _, [Goal]).
bfs([[Node|Path]|Rest], Graph, Goal, Path):-
	member((Node, Adjacents), Graph),
	\+ member(Node, Path),
	(   member(Goal, Adjacents) ->
	Path = [Goal, Node|Path]
	;
	NewPaths = [[Adj, Node|Path] : Adj <- Adjacents],
	bfs(Rest, Graph, Goal, Path) 
	; bfs(NewPaths, Graph, Goal, Path)).
 
