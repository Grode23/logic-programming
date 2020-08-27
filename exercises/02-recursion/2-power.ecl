power(_, 0, 1).

power(Num, Power, Result):-
	NewPower is Power - 1,
	power(Num, NewPower, PrevResult),
	Result is PrevResult * Num.
