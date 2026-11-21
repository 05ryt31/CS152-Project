:- use_module(library(lists)).
:- use_module(library(readutil)).

p12_group_by :-
    read_line_to_string(current_input, N),
    number_codes(N, Number),
    findall(Group, (
        between(1, Number, _),
        read_line_to_string(current_input, Line),
        split_string(Line, ' ', '', Parts),
        nth0(0, Parts, Key),
        nth0(1, Parts, Value),
        number_codes(Value, Val),
        group(Key, Val, Groups)
    ), Groups),
    maplist(print_group, Groups),
    halt.

group(Key, Val, Groups) :-
    (   member([Key, Sum, Count], Groups)
    ->  NewSum is Sum + Val,
        NewCount is Count + 1,
        replace_member([Key, _, _], [Key, NewSum, NewCount], Groups, NewGroups)
    ;   NewGroups = [[Key, Val, 1]] ),
    !,
    Groups = NewGroups.

replace_member(_, New, [], []).
replace_member(X, New, [X|T], [New|T]).
replace_member(X, New, [H|T], [H|R]) :-
    replace_member(X, New, T, R).

print_group([Key, Sum, Count]) :-
    format('~w ~d ~d~n', [Key, Sum, Count]).
