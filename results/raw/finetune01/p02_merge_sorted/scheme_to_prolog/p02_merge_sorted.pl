 
:- use_module(library(lambda)).
 
% merge two lists in order
merge([], B, B):-!.
merge(A, [], A):-!.
merge([H1|T1], [H2|T2], M):- H1=<H2, !, merge(T1,[H1|T2],M).
merge([H1|T1], [H2|T2], M):- merge([H1|T1], T2,M1), append(M1,[H2],M).
 
% merge all lists in order
merge_all([],[]):-!.
merge_all([A],[A]):-!.
merge_all([H1,H2|T],M):- merge(H1,H2,M1), merge_all([M1|T],M).
 
% read lines from stdin
read_lines(N,L):-
    aggregate(nth(N), read_line_to_string(user_input,S), L),
    maplist(\X^Y^(atom_number(X,Y)),L,_).
 
main :-
    read_lines(2,L),
    maplist(atom_number,L,N),
    merge_all(N,M),
    sort(M,M1),
    maplist(writeln,M1).
 
?- main.
 
