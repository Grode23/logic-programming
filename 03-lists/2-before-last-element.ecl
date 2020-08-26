before_last_element([H,_], H).

before_last_element([_|T], Result):-
	before_last_element(T, Result).
