:- use_module(library(lists)).
:- use_module(library(readutil)).

p12_group_by :-
    read_line_to_string(current_input, N),
    string_to_integer(N, NumLines),
    init_sums_and_counts(NumLines, Sums, Counts),
    process_lines(Sums, Counts),
    sort_keys(Sums, SortedKeys),
    write_results(SortedKeys, Sums),
    halt.

init_sums_and_counts(0, [], []).
init_sums_and_counts(N, [Sum|Sums], [Count|Counts]) :-
    Sum = 0,
    Count = 0,
    M is N - 1,
    init_sums_and_counts(M, Sums, Counts).

process_lines(_, []) :- !.
process_lines(Sums, [Sum|Counts]) :-
    read_line_to_string(current_input, Line),
    split_string(Line, " ", _, Parts),
    Key = Parts^0,
    Value = Parts^1,
    integer(Value),
    update_sum_and_count(Sums, Counts, Key, Value, NewSums, NewCounts),
    process_lines(NewSums, NewCounts).

update_sum_and_count([], [], _, _, [], []).
update_sum_and_count([Sum|Sums], [Count|Counts], Key, Value, NewSums, NewCounts) :-
    (   Key == CurrentKey ->
        NewSum is Sum + Value,
        NewCount is Count + 1,
        NewSums = [NewSum|Sums],
        NewCounts = [NewCount|Counts]
    ;   CurrentKey @< Key ->
        NewSums = [Sum|Sums'],
        NewCounts = [Count|Counts'],
        update_sum_and_count(Sums', Counts', Key, Value, NewSums, NewCounts)
    ;   CurrentKey @> Key ->
        NewSums = [Sum|Sums'],
        NewCounts = [Count|Counts'],
        update_sum_and_count(Sums', Counts', Key, Value, NewSums, NewCounts)
    ).

sort_keys(Sums, SortedKeys) :-
    findall(Key, (member(Sum-Sum, Sums), member(Count-Count, Counts), Key = Sum-Key), Keys),
    sort(Keys, SortedKeys).

write_results([], _) :- !.
write_results([Key-Key|Rest], Sums) :-
    findall(Sum-_, member(Sum-_, Sums), Values),
    sum_list(Values, Total),
    count_values(Values, Count),
    format('~w ~d ~d~n', [Key, Total, Count]),
    write_results(Rest, Sums).

count_values([], 0) :- !.
count_values([_|T], C) :-
    count_values(T, C1),
    C is C1 + 1.
