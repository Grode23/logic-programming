lunion([], List, List).

lunion([Head|Tail], List, [Head|Union]):-
	not(member(Head, List)),
	!,
	lunion(Tail, List, Union).

lunion([_|Tail], List, Union):-
	lunion(Tail, List, Union).
