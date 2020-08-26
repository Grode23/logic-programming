sample(2).
sample(5).
sample(14).
sample(7).
sample(26).

less_than_ten(Count):-
	findall(
		X, 
		(
			sample(X), 
			X < 10
		),
		Result),
	length(Result, Count).
