:- use_module(library(lists)).
:- use_module(library(readutil)).

touch(Key, Values) :-
    member(Key-Value, Values),
    delete(Values, Key-_, NewValues),
    append(NewValues, [Key-Value], NewValues2),
    !,
    NewValues2.
touch(_, Values) :-
    Values.

p10_lru :-
    read_line_to_string(current_input, Line1),
    string_to_number(Line1, Capacity),
    read_line_to_string(current_input, Line2),
    string_to_number(Line2, N),
    findall(Line, read_line_to_string(current_input, Line), Lines),
    process_lines(Capacity, N, Lines, [], []),
    !,
    halt.

process_lines(_, _, [], _, Output) :-
    format('~w~n', [Output]).
process_lines(Capacity, N, [Line|Lines], Values, Output) :-
    split_string(Line, " ", "", Parts),
    get_part(Parts, Action, Key, Value),
    handle_action(Action, Key, Value, Capacity, Values, NewValues),
    process_lines(Capacity, N, Lines, NewValues, NewOutput),
    !.

handle_action('get', Key, _, _, Values, Output) :-
    (   member(Key-Value, Values)
    ->  format('~w~n', [Value]),
        touch(Key, Values, NewValues),
        Output = NewValues
    ;   format('-1~n'),
        Output = Values
    ).
handle_action(_, Key, Value, Capacity, Values, Output) :-
    (   member(Key-_, Values)
    ->  touch(Key, Values, NewValues)
    ;   (   length(Values) >= Capacity
        ->  delete_first_key(Values, NewValues)
        ;   NewValues = Values
        ),
        NewValues = [Key-Value | NewValues]
    ),
    Output = NewValues.

delete_first_key([_|T], T).

get_part([Action, Key|_], Action, Key, _).
get_part([Action, Key, Value|_], Action, Key, Value).

string_to_number(S, N) :-
    number_codes(N, S).
