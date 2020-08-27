replace(X, Y, [X|Tail], [Y|Tail]).

replace(X, Y, [Head|Tail], [Head|Tail2]):-
	replace(X, Y, Tail, Tail2).
