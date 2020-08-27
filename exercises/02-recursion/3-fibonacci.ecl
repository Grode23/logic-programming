fibonacci(1, 1).
fibonacci(2, 1).

fibonacci(Num, Result):-
	NewNum1 is Num - 1,
	NewNum2 is Num - 2,
	fibonacci(NewNum1, Result1),
	fibonacci(NewNum2, Result2),
	Result is Result1 + Result2.
