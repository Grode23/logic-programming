% Without recursion
% And with the use of not/1
max_list(Max, List):-
	member(Max, List),
	not((member(Y, List), Y>Max)).
