:- use_module(library(lists)).
:- use_module(library(readutil)).

p12_group_by :-
    read_line_to_string(current_input, Line),
    number_codes(N, Line),
    findall(Group, (
        between(1, N, _),
        read_line_to_string(current_input, InputLine),
        split_string(InputLine, " ", _, [Key, Raw]),
        number_codes(Value, Raw),
        (   get_assoc(Key, Groups, CurrentGroup)
        ->  NewGroup = [CurrentGroup[0] + Value, CurrentGroup[1] + 1]
        ;   NewGroup = [Value, 1]
        ),
        put_assoc(Key, Groups, NewGroup)
    ), GroupsList),
    sort(GroupsList, SortedGroups),
    maplist(print_group, SortedGroups),
    halt.

print_group([Key, Sum, Count]) :-
    format('~w ~d ~d~n', [Key, Sum, Count]).
