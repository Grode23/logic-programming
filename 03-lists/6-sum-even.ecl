sum_even([], 0).

sum_even([Head|Tail], Sum):-
	0 is Head mod 2,
	sum_even(Tail, CurrSum),
	Sum is CurrSum + Head.

sum_even([Head|Tail], Sum):-
	1 is Head mod 2,
	sum_even(Tail, Sum).
