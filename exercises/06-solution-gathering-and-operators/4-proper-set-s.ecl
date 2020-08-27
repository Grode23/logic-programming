proper_set_s(List):-
	setof(X, member(X, List), List1),
	length(List1, N),
	length(List, N).
