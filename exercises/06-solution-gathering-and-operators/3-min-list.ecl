minlist(Min, List):-
	setof(
		X, 
		(
			member(X, List),
			member(Y, List),
			X < Y
		), 
		Min),
	!.
