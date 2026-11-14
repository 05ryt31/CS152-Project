:- initialization(p12_group_by, main).

p12_group_by :- 
    read_line_to_string(user_input, NLine), 
    number_string(N, NLine), 
    rows(N, [], Groups), 
    keysort(Groups, Sorted), 
    print_groups(Sorted),
    halt.

rows(0, Groups, Groups).
rows(N, Groups, Result) :- 
    read_line_to_string(user_input, Line), 
    split_string(Line, " ", " ", [Key, Value]), 
    number_string(V, Value), 
    update(Key, V, Groups, New), 
    N1 is N - 1, 
    rows(N1, New, Result).

update(Key, Value, [], [Key-S-C]) :- 
    S is Value, 
    C = 1.
update(Key, Value, [Key-S-C|Rest], [Key-S1-C1|Rest]) :- 
    S1 is S + Value, 
    C1 is C + 1.
update(Key, Value, [Other|Rest], [Other|NewRest]) :- 
    Key \= Other, 
    update(Key, Value, Rest, NewRest).

print_groups([]).
print_groups([Key-S-C|Rest]) :- 
    format('~w ~w ~w~n', [Key, S, C]), 
    print_groups(Rest).
