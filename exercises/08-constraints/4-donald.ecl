:-lib(ic).
:-lib(ic_global). 

donald(Vars):-
	Vars = [D, O, N, A, L, G, E, R, B, T],
	Vars #:: [0..9],
	ic_global: alldifferent(Vars), 
	%% (D*100000 + O*10000 + N*1000 + A*100 + L*10 + D)
	%% + (G*100000 + E*10000 + R*1000 + A*100 + L*10 + D)
	%% #= (R*100000 + O*10000 + B*1000 + E*100 + R*10 + T),
	(D+G-R)*100000 + (E)*10000 + (N+R-B)*1000 + (A+A-E)*100 + (L+L-R)*10 + (D+D-T) #= 0,
	labeling(Vars),
	!.
