:- initialization(p15_permutations, main).

p15_permutations :-
    read_line_to_string(user_input, Input),
    permutations(Input),
    halt.

permutations(Str) :-
    string_chars(Str, Chars),
    msort(Chars, SortedChars),
    setof(PermStr, PermChars^(
        permutation(SortedChars, PermChars),
        string_chars(PermStr, PermChars)
    ), OrderedPerms),
    maplist(writeln, OrderedPerms).
