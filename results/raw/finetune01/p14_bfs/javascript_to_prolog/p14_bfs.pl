bfs(Graph, Start, End, Path):-
	bfs(Graph, Start, End, [], [Start], Path).
 
bfs(_, _, _, _, _):-!.
 
bfs(Graph, Start, End, Visited, Queue, Path):-
	Queue = [_|Rest],
	member(End, Rest),
	append(Rest, Visited, Visited1),
	make_queue(Graph, Rest, Visited1, Queue1),
	bfs(Graph, Start, End, Visited1, Queue1, Path).
 
bfs(Graph, Start, End, Visited, Queue, Path):-
	Queue = [_|Rest],
	retract(Rest),
	make_queue(Graph, Rest, Visited, Queue1),
	bfs(Graph, Start, End, Visited, Queue1, Path).
 
make_queue(Graph, [], _, []):-!.
 
make_queue(Graph, [Node | Nodes], Visited, Queue):-
	findall(Neigh, edge(Node, Neigh, Graph), Neighbors),
	exclude(member(Node), Neighbors, Neighbors1),
	exclude(member(_), Neighbors1, Neighbors2),
	exclude(member(_), Neighbors2, Neighbors3),
	append(Neighbors3, Visited, Neighbors4),
	append(Rest, Neighbors4, Visited1),
	append(Rest, Visited, Visited1),
	make_queue(Graph, Nodes, Visited1, Queue).
 
edge(X, Y, [[X,Y]|_]).
edge(X, Y, [[Y,X]|_]).
edge(X, Y, [_|T]):-
	edge(X, Y, T).
 
