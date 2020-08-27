:-use_module(library(ic)).
:-use_module(library(ic_global)).
:-use_module(library(branch_and_bound)).

antennas(Amount, MaxDistance, [0|List]):-
	NewAmount is Amount - 1,
	length(List, NewAmount),
	List #:: 1..2^Amount,

	ordered(<,List), %% Display ordered

	first([0|List], Distances),

	ic_global:alldifferent(Distances),
	ic_global:maxlist(Distances, MaxDistance),
	bb_min(labeling(List), MaxDistance, bb_options{strategy:continue}).


first([], []).

first([Element|Elements], Distances):-
	second(Element, Elements, NewDistances),
	first(Elements, RestDistances),
	append(NewDistances, RestDistances, Distances).


second(_, [], []).

second(Element, [HeadElement|RestElements], [Distance|Distances]):-
	Distance #= HeadElement - Element,
	second(Element, RestElements, Distances).
