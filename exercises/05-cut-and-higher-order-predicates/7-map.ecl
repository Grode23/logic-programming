square(X, R):-
	R is X*X.

double(X, R) :-
	R is 2*X.

map(_, [], []).

map(Operation, [X|Tail], [Y|ResTail]):-
	C =.. [Operation, X, Y],
	call(C),
	map(Operation, Tail, ResTail).
