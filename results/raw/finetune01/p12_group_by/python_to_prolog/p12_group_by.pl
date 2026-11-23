```prolog
group_by :-
	L = ["a"-"b", "c"-"d", "e"-"f", "a"-"g", "c"-"h"],
	group_pairs(L, L1),
	map_list_pair(aggregate, L1, L2),
	sort(L2, L3),
	map_list_pair(print, L3).
 
% aggregate(Key, [Value|Values], Aggr)
aggregate(Key, [Value|Values], aggr(Key, Value, Values)).
 
% aggregate(Aggr, Key, Aggr)
aggregate(aggr(Key, Value, Values), Key, aggr(Key, Value, Values)).
 
% aggregate(Aggr, _, Aggr)
aggregate(_, _, Aggr) :- !.
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, Key, _).
 
% aggregate(Aggr, Key, Aggr)
aggregate(Aggr, Key, Aggr) :- aggregate(Aggr, _, Key).
 
% aggregate(Ag
