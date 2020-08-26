:-lib(ic).
:-lib(ic_global).
:-lib(branch_and_bound).
:-lib(ic_edge_finder).

%% Backup(Type, name, releaseDate, Duration, Bandwidth)
backup(db,srv_d1, 0, 5, 10).
backup(db,srv_d2, 2, 8, 18).
backup(db,srv_d3, 0, 4, 11).
backup(web,srv_w1, 0, 7, 8).
backup(web,srv_w2, 3, 11, 10).

schedule_backups(ReturnDB, ReturnWeb, MakeSpan):-
	% Get data for databases
	findall(DatabaseName, backup(db, DatabaseName, _, _, _), Databases),
	findall(Start, backup(db, _, Start, _, _), StartsDataBase),
	findall(Duration, backup(db, _, _, Duration, _), DurationsDatabase),
	findall(Bandwidth, backup(db, _, _, _, Bandwidth), BandwidthsDatabase),

	% Get data for webs
	findall(WebName, backup(web, WebName, _, _, _), Webs),
	findall(Start, backup(web, _, Start, _, _), StartsWeb),
	findall(Duration, backup(web, _, _, Duration, _), DurationsWeb),
	findall(Bandwidth, backup(web, _, _, _, Bandwidth), BandwidthsWeb),

	% Get the amount of databases
	length(Databases, LenDatabase),
	% Get the amount of webs
	length(Webs, LenWeb),
	
	% Initiliaze length of lists with start values of databases
	length(ActualStartsDatabase, LenDatabase),
	% Initiliaze length of lists with start values of webs
	length(ActualStartsWeb, LenWeb),

	%% Initiliaze start of each element
	values_to_starts(ActualStartsDatabase, StartsDataBase),
	values_to_starts(ActualStartsWeb, StartsWeb),

	% Specify that it isn't possible to backup more than one of each kind 
	% at the same time
	disjunctive(ActualStartsDatabase, DurationsDatabase),
	disjunctive(ActualStartsWeb, DurationsWeb),

	% Get lists with data of both databases and webs
	append(ActualStartsDatabase, ActualStartsWeb, Starts),
	append(DurationsDatabase, DurationsWeb, Durations),
	append(BandwidthsDatabase, BandwidthsWeb, Bandwidths),

	% Initiliaze end values 
	crossing_times(Starts,Durations,Ends),

	% Get the biggest values of all end values
	% This will not get actual values, but set of values
	ic:maxlist(Ends,MakeSpan),

	% Find solution with bandwidth no more than 25
	cumulative(Starts,Durations,Bandwidths,25),
	% Use Branch and Bound to find the optimal solution
	% Minimize Duration 
	bb_min(labeling(Starts),MakeSpan,bb_options{strategy:restart}),

	% Create variables/lists that will be returned
	length(ReturnStartsDatabase, LenDatabase),
	append(ReturnStartsDatabase, _, Starts),

	length(ReturnStartsWeb, LenWeb),
	append(_, ReturnStartsWeb, Starts),

	% Give the form I need to the return values
	ReturnDB =.. [db|[ReturnStartsDatabase]],

	ReturnWeb =.. [db|[ReturnStartsWeb]],

	%% Don't return No as a result
	!.

values_to_starts([], []).
values_to_starts([ActualStart|RestActualStarts], [Start|RestStarts]):-
	ActualStart #:: Start..inf,
	values_to_starts(RestActualStarts, RestStarts).

crossing_times([],[],[]).
crossing_times([Start|Starts],[Duration|Durations],[End|Ends]):-
 	Start + Duration #= End,  
 	crossing_times(Starts,Durations,Ends). 
