% This can be used with Operations like max/3, min/3, times/3, plus/3 etc

reduce(_, [X], X).

reduce(Operation, [X, Y|Tail], Result):-	
	C =.. [Operation, X, Y, Res],
	call(C),
	reduce(Operation, [Res|Tail], Result).
