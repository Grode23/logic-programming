sumoflist([X], X).

sumoflist([FirstNum|RestOfNums], Result):-
	sumoflist(RestOfNums, PrevResult),
	Result is PrevResult + FirstNum.
