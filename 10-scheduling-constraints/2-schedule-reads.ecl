:-lib(ic).
:-lib(ic_global).
:-lib(branch_and_bound).
:-lib(ic_edge_finder).

% Subject | Duration | Dates
reading(course1,3,12). 
reading(course2,5,20). 
reading(course3,2,8). 
reading(course4,7,22).

schedule_reads(Starts):-
	findall(Duration, reading(_, Duration, _), Durations),
	findall(Date, reading(_, _, Date), Dates),

	length(Durations, Length),
	length(Starts, Length),

	Starts #:: 1..60, % 60 as 2 months period
	disjunctive(Starts, Durations),
	endTimes(Durations, Starts, Ends, Dates),
	ic:maxlist(Ends,MakeSpan),
	bb_min(labeling(Starts), MakeSpan, _).


endTimes([], [], [], []).

endTimes([Duration|RestDuration], [Start|RestStarts], [End|RestEnds], [Date|RestDates]):-
	End #= Start + Duration,
	End #< Date,
	endTimes(RestDuration, RestStarts, RestEnds, RestDates).

