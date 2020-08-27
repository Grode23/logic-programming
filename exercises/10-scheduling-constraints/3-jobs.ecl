:-lib(ic).
:-lib(ic_global).
:-lib(branch_and_bound).
:-lib(ic_edge_finder).

job(f1, a1, 5, 5, 20).
job(f2, a2, 20, 0, 40).
job(f3, a3, 15, 10, 35).
job(f1, b1, 5, 0, 30).
job(f2, b2, 10, 10, 25).
job(f3, b3, 5, 5, 30).
job(f1, c1, 10, 0, 15).
job(f2, c2, 15, 10, 35).
job(f3, c3, 10, 20, 35).

solve(Starts):-

	%%% CONDITIONS TO EMPLOYEES

	%% initialization of Starts happens into groupThem
	groupThem(f1, Starts1, Jobs1),
	getEnds(Starts1, Ends1, Jobs1),

	groupThem(f2, Starts2, Jobs2),
	getEnds(Starts2, Ends2, Jobs2),

	groupThem(f3, Starts3, Jobs3),
	getEnds(Starts3, Ends3, Jobs3),

	%%% CONDITIONS TO JOBS
	inOrder(Starts2, Starts3, Ends1, Ends2),

	%% Group all together
	append(Starts1,Starts2,TempStarts),
	append(TempStarts, Starts3, Starts),

	append(Ends1, Ends2, TempEnds),
	append(TempEnds, Ends3, Ends),

	ic:maxlist(Ends,MakeSpan),
	bb_min(labeling(Starts), MakeSpan, _).

inOrder([], [], [], []).

inOrder([Start2|Starts2], [Start3|Starts3], [End1|Ends1], [End2|Ends2]):-
	End1 #=< Start2,
	End2 #=< Start3,
	inOrder(Starts2, Starts3, Ends1, Ends2).

getEnds([], [], []).

getEnds([Start|RestStarts], [Lateness|RestLatenesses], [Job|Jobs]):-
	job(_, Job, Duration, _, DueDate),

	Lateness #= (Start + Duration) - DueDate,
	getEnds(RestStarts, RestLatenesses, Jobs).

initializeStarts([], []).

initializeStarts([Start|RestStarts], [Job|Jobs]):-
	job(_, Job, _, ReleaseDate, DueDate),

	Start #:: [ReleaseDate..DueDate],
	initializeStarts(RestStarts, Jobs).


groupThem(Employee, Starts, Jobs):-
	findall(Job, job(Employee, Job, _, _, _), Jobs),
	findall(Duration, job(Employee, _, Duration, _, _), Durations),

	length(Jobs, Length),
	length(Starts, Length),

	initializeStarts(Starts, Jobs),
	disjunctive(Starts, Durations).
