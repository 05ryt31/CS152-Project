```prolog
 
:- use_module(library(clpfd)).
 
% Stack VM
 
% Stack VM instruction set
%
% push X   -- Pushes X onto the stack
% pop      -- Pops the top element off the stack
% add      -- Adds the top two elements of the stack together
% mul      -- Multiplies the top two elements of the stack together
% dup      -- Duplicates the top element of the stack
% swap     -- Swaps the top two elements of the stack
% print    -- Prints the top element of the stack
 
% Stack VM instruction set
%
% push(X, S, S1) :- append(S, [X], S1).
% pop(S, X, S1) :- append(_S, [X|S1], S).
% add(S, X, S1) :- append(_S, [Y,X|_S1], S), X #= Y + Z, append(_S, [Z|S1], S1).
% mul(S, X, S1) :- append(_S, [Y,X|_S1], S), X #= Y * Z, append(_S, [Z|S1], S1).
% dup(S, X, S1) :- append(_S, [X|_S1], S), append(_S, [X,X|_S1], S1).
% swap(S, X, S1):- append(_S, [Y,X|_S1], S), append(_S, [X,Y|_S1], S1).
% print(S, X, S1):- append(_S, [X|_S1], S), writef('%w\n', [X]).
 
% Stack VM instruction set
%
% push(X, S, S1) :- append(S, [X], S1).
% pop(S, X, S1) :- append(_S, [X|S1], S).
% add(S, X, S1) :- append(_S, [Y,X|_S1], S), X #= Y + Z, append(_S, [Z|S1], S1).
% mul(S, X, S1) :- append(_S, [Y,X|_S1], S), X #= Y * Z, append(_S, [Z|S1], S1).
% dup(S, X, S1) :- append(_S, [X|_S1], S), append(_S, [X,X|_S1], S1).
% swap(S, X, S1):- append(_S, [Y,X|_S1], S), append(_S, [X,Y|_S1], S1).
% print(S, X, S1):- append(_S, [X|_S1], S), writef('%w\n', [X]).
 
% Stack VM instruction set
%
% push(X, S, S1) :- append(S, [X], S1).
% pop(S, X, S1) :- append(_S, [X|S1], S).
% add(S, X, S1) :- append(_S, [Y,X|_S1], S), X #= Y + Z, append(_S, [Z|S1], S1).
% mul(S, X, S1) :- append(_S, [Y,X|_S1], S), X #= Y * Z, append(_S, [Z|S1], S1).
% dup(S, X, S1) :- append(_S, [X|_S1], S), append(_S, [X,X|_S1], S1).
% swap(S, X, S1):- append(_S, [Y,X|_S1], S), append(_S, [X,Y|_S1], S1).
% print(S, X, S1):- append(_S, [X|_S1], S), writef('%w\n', [X]).
 
% Stack VM instruction set
%
% push(X, S, S1) :- append(S, [X], S1).
% pop(S, X, S1) :- append(_S, [X|S1], S).
% add(S, X, S1) :- append(_S, [Y,X|_S1], S), X #= Y + Z, append(_S, [Z|S1], S1).
% mul(S, X, S1) :- append(_S, [Y,X|_S1], S), X #= Y * Z, append(_S, [Z|S1], S1).
% dup(S, X, S1) :- append(_S, [X|_S1], S), append(_S, [X,X|_S1], S1).
% swap(S, X, S1):- append(_S, [Y,X|_S1], S), append(_S, [X,Y|_S1], S1).
% print(S, X, S1):- append(_S, [X|_S1], S), writef('%w\n', [X]).
 
% Stack VM instruction set
%
% push(X, S, S1) :- append(S, [X], S1).
% pop(S, X, S1) :- append(_S, [X|S1], S).
% add(S, X, S1) :- append(_S, [Y,X|_S1], S), X #= Y + Z, append(_S, [Z|S1], S1).
% mul(S, X, S1) :- append(_S, [Y,X|_S1], S), X #= Y * Z, append(_S, [Z|S1], S1).
% dup(S, X, S1) :- append(_S, [X|_S1], S), append(_S, [X,X|_S1], S1).
% swap(S, X, S1):- append(_S, [Y,X|_S1], S), append(_S, [X,Y|_S1], S1).
% print(S, X, S1):- append(_S, [X|_S1], S), writef('%w\n', [X]).
 
% Stack VM instruction set
%
% push(X, S, S1) :- append(S, [X], S1).
% pop(S, X, S1) :- append(_S, [X|S1], S).
% add(S, X, S1) :- append(_S, [Y,X|_S1], S), X #= Y + Z, append(_S, [Z|S1], S1).
% mul(S, X, S1) :- append(_S, [Y,X|_S1], S), X #= Y * Z, append(_S, [Z|S1], S1).
% dup(S, X, S1) :- append(_S, [X|_S1], S), append(_S, [X,X|_S1], S1).
% swap(S, X, S1):- append(_S, [Y,X|_S1], S), append(_S, [X,Y|_S1], S1).
% print(S, X, S1):- append(_S, [X|_S1], S), writef('%w\n', [X]).
 
% Stack VM instruction set
%
% push(X, S, S1) :- append(S, [X], S1).
% pop(S, X, S1) :- append(_S, [X|S1], S).
% add(S, X, S1) :- append(_S, [Y,X|_S1], S), X #= Y + Z, append(_S, [Z|S1], S1).
% mul(S, X, S1) :- append(_S, [Y,X|_S1], S), X #= Y * Z, append(_S, [Z|S1], S1).
% dup(S, X, S1) :- append(_S, [X|_S1], S), append(_S, [X,X|_S1], S1).
% swap(S, X, S1):- append(_S, [Y,X|_S1], S), append(_S, [X,Y|_S1], S1).
% print(S, X, S1):- append(_S, [X|_S1], S), writef('%w\n', [X]).
 
% Stack VM instruction set
%
% push(X, S, S1) :- append(S, [X], S1).
% pop(S, X, S1) :- append(_S, [X|S1], S).
% add(S, X, S1) :- append(_S, [Y,X|_S1], S), X #= Y + Z, append(_S, [Z|S1], S1).
% mul(S, X, S1) :- append(_S, [Y,X|_S1], S), X #= Y * Z, append(_S, [Z|S1], S1).
% dup(S, X, S1) :- append(_S, [X|_S1], S), append(_S, [X,X|_S1], S1).
% swap(S, X, S1):- append(_S, [Y,X|_S1], S), append(_S, [X,Y|_S1], S1).
% print(S, X, S1
