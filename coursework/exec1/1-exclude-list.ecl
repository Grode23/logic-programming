%%  List Processing

% Initialize list as empty and stop recursion
exclude_range(_, _, [], []).

% Add it if it is not between Low and High
exclude_range(Low, High, [Item|RestOfList], [Item|NewList]):-
	(Item > High;
	Item < Low),
	!,
	exclude_range(Low, High, RestOfList, NewList).

% If it is between the Low and High
exclude_range(Low, High, [_|RestOfList], NewList):-
	exclude_range(Low, High, RestOfList, NewList).
