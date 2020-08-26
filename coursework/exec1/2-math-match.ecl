%%  Matching Number Series

% Functions to use
double(X,Y):- Y is X * 2.
inc(X,Y):- Y is X + 1.
square(X,Y):- Y is X * X.

%%	Recursive version

math_match([_], _, []):- 
	!. % Cut helps in case of empty list with no solutions. Otherwise it would execute one more time for no reason

% Call operation and add it if it is true then continue
math_match([First, Second|RestOfList], C, [(First, Second)|Solution]):-
	Operation =.. [C, First, Second],
	call(Operation),
	math_match([Second|RestOfList], C, Solution),
	!.

% Call operation and continue if it is NOT true
math_match([First, Second|RestOfList], C, Solution):-
	Operation =.. [C, First, Second],
	not(call(Operation)),
	math_match([Second|RestOfList], C, Solution).

%%	Non-recursive version

math_match_alt(List, C, Solution):-
	findall(
		(X, Y),
		(
			append(_Prefix, [X, Y | _Suffix], List), % Get two consecutive elements from the list
			Operation =.. [C, X, Y],
			call(Operation)
		), 
		Solution).
