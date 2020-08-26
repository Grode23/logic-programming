:-lib(ic).
:-lib(ic_global).
:-lib(ic_edge_finder).

arrange_list(Len, List):-
	
	% Initiliaze length of list
	length(List, Len),

	% Initiliaze elements of list
	initiliaze_values(List, Len),

	% Get a list of numbers from 1 to length of List
	length(Indexes, Len),
	array_indexes(Indexes),
	
	% Add the constraints
	contraints_indexes(List, Indexes),

	% Every element must contain a different value
	ic_global:alldifferent(List),
	
	% Get final values of elements
	labeling(List).



contraints_indexes([], []).

contraints_indexes([Element|RestElements], [Index|RestIndexes]):-
	
	% Contraint of problem 
	%% (Element #< Index - 2;
	%% Element #> Index + 2),

	abs(Element - Index) #> 2

	contraints_indexes(RestElements, RestIndexes).

array_indexes(Indexes):-
	array_indexes(0, Indexes).

array_indexes(_, []).

array_indexes(ToGive, [NewIndex|Rest]):-
	NewIndex is ToGive + 1,
	array_indexes(NewIndex, Rest).

initiliaze_values([], _).

initiliaze_values([First|Rest], Len):-
	First #:: 1..Len,
	initiliaze_values(Rest, Len).
