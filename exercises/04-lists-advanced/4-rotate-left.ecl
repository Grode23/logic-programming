rotate_left(Pos, List, Result):-
	length(Left, Pos),
	append(Left, Right, List),
	append(Right, Left, Result).
