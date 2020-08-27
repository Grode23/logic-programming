% Sadly, without not/1

unique_element(Elem, List):-
	member(Elem, List),
	count_times(Elem, List, Times),
	not(Times \= 1).

count_times(_, [], 0).

count_times(Elem, [Head|Tail], Times):-
	Elem = Head,
	!,
	count_times(Elem, Tail, PrevTimes),
	Times is PrevTimes + 1.

count_times(Elem, [Head|Tail], Times):-
	count_times(Elem, Tail, Times).
