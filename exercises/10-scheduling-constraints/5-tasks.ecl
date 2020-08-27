:-lib(ic).
:-lib(ic_global).
:-lib(branch_and_bound).
:-lib(ic_edge_finder).

%Job | Duration | Requirements
stuff(1, 5, 4).
stuff(2, 8, 3).
stuff(3, 13, 4).
stuff(4, 19, 7).
stuff(5, 20, 12).
stuff(6, 19, 3).
stuff(7, 12, 3).
stuff(8, 40, 3).
stuff(9, 10, 3).
stuff(10, 9, 2).


solveFive(Starts):-
	
	findall(Duration, stuff(_, Duration, _), Durations),
	findall(Recourse, stuff(_, _, Recourse), Recourses),
	
	Starts = [_, _, St3, St4, _, _, St7, _, St9, St10],
	Ends = [End1, End2, End3, _, End5, End6, End7, End8, _, _],
	
	Starts #:: 0..inf,

	length(Durations, Length),
	length(TeamsRecourses, Length),
	TeamsRecourses #:: 1,

	St3 #> End2,
	St4 #> End1,
	St7 #> End2,
	St7 #> End3,
	St9 #> End5,
	St9 #> End6,
	St9 #> End7,
	St10 #> End2,
	St10 #> End8,

	cumulative(Starts, Durations, TeamsRecourses, 3), % how many teams
	cumulative(Starts, Durations, Recourses, 12),% Actual recourselimit

	findEnds(Starts, Durations, Ends),
	ic_global:maxlist(Ends, MakeSpan),

	bb_min(labeling(Starts), MakeSpan, bb_options{strategy:restart}).



findEnds([], [], []).

findEnds([Start|RestStarts], [Duration|RestDurations], [End|RestEnds]):-
	End #= Start + Duration,
	findEnds(RestStarts, RestDurations, RestEnds).
