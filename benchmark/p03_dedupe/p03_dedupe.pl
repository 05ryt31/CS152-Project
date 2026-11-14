:- initialization(p03_dedupe, main).

p03_dedupe :- 
    read_line_to_string(user_input, Line), 
    nums(Line, Ns),
    unique(Ns, [], Result), 
    print_nums(Result).

nums(end_of_file, []) :- !.
nums("", []) :- !.
nums(Line, []) :- split_string(Line, " ", " ", []).
nums(Line, Ns) :- 
    split_string(Line, " ", " ", Parts), 
    Parts \= [], 
    maplist(number_string, Ns, Parts).

unique([], _, []).
unique([X|Xs], Seen, Result) :- 
    memberchk(X, Seen), 
    unique(Xs, Seen, Result).
unique([X|Xs], Seen, [X|Result]) :- 
    \+ memberchk(X, Seen), 
    unique(Xs, [X|Seen], Result).

print_nums([]).
print_nums(Ns) :- 
    atomic_list_concat(Ns, ' ', Text), 
    writeln(Text).
