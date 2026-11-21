:- use_module(library(lists)).
:- use_module(library(readutil)).

p03_dedupe :-
    read_line_to_string(current_input, Line),
    (   Line = ''
    ->  true
    ;   string_tokens(Line, Tokens, ' \t\n\r'),
        process_tokens(Tokens, Seen, Result),
        (   Result = []
        ->  true
        ;   format('~w~n', [Result])
        )
    ),
    halt(0).

process_tokens([], _, []) :- !.
process_tokens([Token | Rest], Seen, Result) :-
    integer(Token),
    (   memberchk(Token, Seen)
    ->  process_tokens(Rest, Seen, Result)
    ;   append(Result, [Token], NewResult),
        process_tokens(Rest, [Token | Seen], NewResult)
    ).

string_tokens(S, Tokens, Delims) :-
    atom_codes(S, Codes),
    string_tokens(Codes, Tokens, Delims, []).

string_tokens([], [], _, Acc) :-
    reverse(Acc, Tokens).
string_tokens([C | Cs], Tokens, Delims, Acc) :-
    (   member(C, Delims)
    ->  string_tokens(Cs, Tokens, Delims, [])
    ;   append(Acc, [C], NewAcc),
        string_tokens(Cs, Tokens, Delims, NewAcc)
    ).
