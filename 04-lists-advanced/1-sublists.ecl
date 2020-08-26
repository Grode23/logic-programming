symmetric(List):-
	append(Part, Part, List).

end_sublist(Part, List):-
	append(_, Part, List).

twice_sublist(Part, List):-
	append(List1, List2, List),
	sublist(Part, List1),
	sublist(Part, List2).

sublist(Part, List):-
	append(Sublist1, _, List),	
	append(_, Part, Sublist1).

last_element([X], X).

last_element([_|Tail], LastElement):-
	last_element(Tail, LastElement).
