count_odd([], 0).

count_odd([H|T], Times):-
	1 is H mod 2,
	count_odd(T, Times2),
	Times is Times2 + 1.

count_odd([H|T], Times):-
	0 is H mod 2,
	count_odd(T, Times).
