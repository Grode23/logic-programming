connected(rb1, i1, b2).
connected(rb1, i1, b3).
connected(rb1, i2, b4).
connected(i1, i2, b1).
connected(rb2, i1, b5).
connected(rb2, i1, b6).
connected(rb2, i2, b7).

connection(State1, State2, Through):-
	connected(State1, State2, Through).

connection(State1, State2, Through):-
	connected(State2, State1, Through).

walk(Start, Finish, Bridges):-
	walk(Start, Finish, [], Bridges).

walk(Start, Finish, Visited, [Bridge]):-
	connection(Start, Finish, Bridge),
	not(member(Bridge, Visited)).

walk(Start, Finish, Visited, [Bridge|RestBridges]):-
	connection(Start, NewStart, Bridge),
	not(member(Bridge, Visited)),
	walk(NewStart, Finish, [Bridge|Visited], RestBridges).

% There is no path to cross every bridge only once
euler:-
	member(Start, [rb1, rb2, i1, i2]),
	member(Finish, [rb1, rb2, i1, i2]),
	walk(Start, Finish, Bridges),
	length(Bridges, 7).
