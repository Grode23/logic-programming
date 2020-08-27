:-lib(ic).
:-lib(ic_global). 

num_gen(N1, N2):-
	[M1, M3, M4, M6, M7, M9] #:: [0..9],
	ic_global: alldifferent([M1, M3, M4, M6, M7, M9, 5, 3, 0, 1]),
	N1 #= M1*10000 + 5*1000 + M3*100 + M4*10 + 3,
	N2 #= M6*10000 + M7*1000 + 0*100 + M9*10 + 1,
	12848 #= abs(N1 - N2),
	labeling([M1, M3, M4, M6, M7, M9]).

