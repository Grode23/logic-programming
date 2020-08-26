square(X, R):-
	R is X*X.

double(X, R) :-
	R is 2*X.

map_f(Operation, List, Result):-
	findall(
		X,
		(
			member(Mem, List),
			C =.. [Operation, Mem, X],
			call(C)
		),
		Result).
