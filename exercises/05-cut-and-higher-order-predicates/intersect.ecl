intersect([],_,[]).

intersect([X|Rest],List,[X|IntList]):-
	member(X,List), 
	!,
	intersect(Rest,List,IntList).

intersect([X|Rest],List,IntList):-
	not(member(X,List)), 
	intersect(Rest,List,IntList).
