% Find sum from 1 to N numbers

sumn(1, 1).

sumn(X, Result1) :-
	X > 1,
	XX is X - 1,
	sumn(XX, Result2),
	Result1 is Result2 + X.    