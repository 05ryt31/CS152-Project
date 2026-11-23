 
merge([], B, B).
merge(A, [], A).
merge([H1|T1], [H2|T2], M):- H1=<H2, !, merge(T1,[H1|M]).
merge([H1|T1], [H2|T2], M):- H1>H2, merge([H1|T1], T2, M1), merge(M1,[H2|M]).
 
