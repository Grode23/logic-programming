occurs(_,[], 0).

occurs(Element, [Element|T], Times):-
	occurs(Element, T, Times2),
	Times is Times2 + 1.

occurs(Element, [H|T], Times):-
	Element \= H,
	occurs(Element, T, Times).
