set_diff([], _, []).

set_diff([Head|Tail], List, Result):-
	member(Head, List),
	set_diff(Tail, List, Result).

set_diff([Head|Tail], List, [Head|Result]):-
	not(member(Head, List)),
	set_diff(Tail, List, Result).
