set_diff_f(List1, List2, Result):-
	findall(
		X,
		(
			member(X, List1),
			not(member(X, List2))
		), 
		Result).
