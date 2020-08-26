:-lib(ic).
:-lib(ic_global).
:-lib(ic_sets).
:-lib(branch_and_bound). 

value([10,30,45,50,65,70,75,80,90,100]). 
weight([100,110,200,210,240,300,430,450,500,600]).

thiefs(NumOfThiefs, Thiefs, TotalValue):-

	value(Values),
	weight(Weights),
	length(Values, AllStuff),
	
	% initialize the thiefs (in this case, there are three of them)
	length(Thiefs, NumOfThiefs),
	intsets(Thiefs, NumOfThiefs, 1, AllStuff),

	% Everyone has their own truck with stuff
	all_disjoint(Thiefs),

	WeightsArray =.. [a|Weights],
	ValuesArray =.. [a|Values],

	calculations(Thiefs, WeightsArray, ValuesArray, TotalValue),
	
	sumlist(Values, Sum),
	NewVar #= Sum - TotalValue,
	bb_min(labelSets(Thiefs), NewVar, bb_options{strategy:restart}).


initializeThiefs([], _, 0).
initializeThiefs([Thief|RestThiefs], AllStuff, Amount):-
	intset(Thief, 1, AllStuff),
	NextAmount is Amount - 1,
	initializeThiefs(RestThiefs, AllStuff, NextAmount).


calculations([],_,_, 0).
calculations([G|Groups],Weights, Values, TotalValue):-
	weight(G, Weights, Weight),
	weight(G, Values, Value),
	Weight #=< 600,
	calculations(Groups,Weights, Values, PrevValue),
	TotalValue #= Value + PrevValue. 