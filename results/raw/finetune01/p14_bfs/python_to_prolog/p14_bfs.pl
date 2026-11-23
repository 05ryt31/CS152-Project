bfs :-
	L = [a,b,c,d,e,f,g,h,i,j,k,l,m,n,o,p,q,r,s,t,u,v,w,x,y,z],
	permutation(L,L1),
	assert(graph(a,b)),
	assert(graph(b,a)), assert(graph(a,c)), assert(graph(c,a)),
	assert(graph(b,d)), assert(graph(d,b)), assert(graph(b,e)), assert(graph(e,b)),
	assert(graph(c,f)), assert(graph(f,c)), assert(graph(c,g)), assert(graph(g,c)),
	assert(graph(d,h)), assert(graph(h,d)), assert(graph(d,i)), assert(graph(i,d)),
	assert(graph(e,j)), assert(graph(j,e)), assert(graph(e,k)), assert(graph(k,e)),
	assert(graph(f,l)), assert(graph(l,f)), assert(graph(f,m)), assert(graph(m,f)),
	assert(graph(g,n)), assert(graph(n,g)), assert(graph(g,o)), assert(graph(o,g)),
	assert(graph(h,p)), assert(graph(p,h)), assert(graph(h,q)), assert(graph(q,h)),
	assert(graph(i,r)), assert(graph(r,i)), assert(graph(i,s)), assert(graph(s,i)),
	assert(graph(j,t)), assert(graph(t,j)), assert(graph(j,u)), assert(graph(u,j)),
	assert(graph(k,v)), assert(graph(v,k)), assert(graph(k,w)), assert(graph(w,k)),
	assert(graph(l,x)), assert(graph(x,l)), assert(graph(l,y)), assert(graph(y,l)),
	assert(graph(m,z)), assert(graph(z,m))),
	bfs(a, z, L1).
 
bfs(S, T, L) :-
	bfs(S, T, L, [], [S]).
 
bfs(T, T, _, _, _) :- !.
bfs(_, _, _, Closed, _) :-
	member(_, Closed), !, fail.
bfs(S, T, L, Closed, Open) :-
	get_open(Open, S, RestOpen),
	get_successors(S, L, Successors),
	append(Closed, [S], NewClosed),
	append(RestOpen, Successors, NewOpen),
	bfs(T, T, L, NewClosed, NewOpen).
 
get_open([S|_Rest], S, _Rest) :- !.
get_open([_|Rest], S, RestOpen) :-
	get_open(Rest, S, RestOpen).
 
get_successors(N, L, Successors) :-
	findall(M, graph(N,M) & member(M,L), Successors).
 
