 
:- use_module(library(lambda)).
 
permute([],[]).
permute(L,[X|T]) :-
	select(X,L,R),
	permute(R,T).
 
perms(Word,Perms) :-
	length(Word,N),
	integer(N),
	mbagof(PERM, permute(Word,PERM), Perms).
 
print_perms(Word) :-
	perms(Word,Perms),
	maplist(writeln,Perms).
 
