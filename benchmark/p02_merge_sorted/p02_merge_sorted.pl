:- initialization(p02_merge_sorted, main).

p02_merge_sorted :- 
    read_line_to_string(user_input, ALine), 
    read_line_to_string(user_input, BLine), 
    nums(ALine, A), 
    nums(BLine, B), 
    merge(A, B, Result), 
    print_nums(Result).

nums(end_of_file, []) :- !.
nums("", []) :- !.
nums(Line, []) :- split_string(Line, " ", " ", []).
nums(Line, Ns) :- 
    split_string(Line, " ", " ", Parts), 
    Parts \= [], 
    maplist(number_string, Ns, Parts).

merge([], Ys, Ys).
merge(Xs, [], Xs).
merge([X|Xs], [Y|Ys], [X|Rest]) :- 
    X =< Y, 
    merge(Xs, [Y|Ys], Rest).
merge([X|Xs], [Y|Ys], [Y|Rest]) :- 
    X > Y, 
    merge([X|Xs], Ys, Rest).

print_nums([]).
print_nums(Ns) :- 
    atomic_list_concat(Ns, ' ', Text), 
    writeln(Text).
