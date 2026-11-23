bfs(Graph, Start, End, Path):-
	bfs(Graph, Start, [End], [], Path).
 
bfs(Graph, Node, Visited, Path, Path):- member(Node, Visited), !.
bfs(Graph, Node, Visited, Path, FinalPath):-
	member(Edge, Graph),
	Edge = [Node, Other],
	\+member(Other, Visited),
	!,
	bfs(Graph, Other, [Node | Visited], Path, FinalPath).
bfs(Graph, Node, Visited, Path, FinalPath):-
	member(Edge, Graph),
	Edge = [Other, Node],
	\+member(Other, Visited),
	!,
	bfs(Graph, Other, [Node | Visited], Path, FinalPath).
bfs(Graph, Node, Visited, Path, FinalPath):-
	member(Edge, Graph),
	Edge = [Other, _],
	Other \= Node,
	Other \= End,
	\+member(Other, Visited),
	!,
	bfs(Graph, Node, Visited, [Other | Path], FinalPath).
bfs(_, _, _, [End | _], [End]).
bfs(Graph, Node, Visited, Path, FinalPath):-
	member(Edge, Graph),
	Edge = [Other, _],
	Other \= Node,
	Other \= End,
	\+member(Other, Visited),
	!,
	bfs(Graph, Node, Visited, [Other | Path], FinalPath).
