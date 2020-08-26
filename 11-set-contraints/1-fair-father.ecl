:-lib(ic).
:-lib(ic_global).
:-lib(ic_sets).
:-lib(branch_and_bound).

houses([1,3,4,5,6,10,12,14,15,17,20,22]).

fair_father(S1, S2, S3):-
	houses(Houses),
	length(Houses,AllNums),
	intset(S1, 1, AllNums),
	intset(S2, 1, AllNums),
	intset(S3, 1, AllNums),
	all_disjoint([S1, S2, S3]),

	Array =.. [a|Houses],
	sums([S1, S2, S3], Array, 43),
	labelSets([S1, S2, S3]).


sums([],_,_).
sums([G|Groups],Array,S):-
	weight(G,Array,W),
	W #= S,
	sums(Groups,Array,S).


labelSets([]).
labelSets([G|Groups]):-
	insetdomain(G,_,_,_),
	labelSets(Groups).
