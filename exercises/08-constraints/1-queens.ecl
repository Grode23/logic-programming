:-lib(ic).
:-lib(ic_global). %% For sumlist

%% NOT WRITTEN BY ME
%% I upload it to keep a track of every solved exercise

measure_time(Goal):-
	statistics(times,[UserCPU,SysCPU,Clock]),
	call(Goal),
 	statistics(times,[NewUserCPU,NewSysCPU,NewClock]),
	UCPU is NewUserCPU - UserCPU,
	SCPU is NewSysCPU - SysCPU,
	RTIME is NewClock - Clock,
	write('User Time (secs):: ' ) , writeln(UCPU),
    write('Sys Time (secs):: ' ) , writeln(SCPU),
	write('Clock (secs):: ' ) , writeln(RTIME).
	
%%% N Queens Constraint Version with simple labeling
queens(N,List):-
	length(List,N),        
	List #:: 1..N,
    alldifferent(List), %% different row
	apply_constraints(List),
    labeling(List).

%%% N Queens Constraint Version with heuristics and value ordering
queens(N,List,Strategy,ValueOrdering):-
	length(List,N),        
	List #:: 1..N,
	alldifferent(List), %% different row
	apply_constraints(List),
	search_for_solution(List,Strategy, ValueOrdering).

%%% You can try different heurstics and different Value ordering here.
search_for_solution(List,Strategy,ValueOrdering):-
	search(List,0,Strategy,ValueOrdering,complete, []).

%%% Constraints
apply_constraints([]).
apply_constraints([X|Rest]):-
        safe(X,Rest,1),
        apply_constraints(Rest).

%%% A safe queen
safe(_,[],_).
safe(X,[Y|Rest],Pos):-
        noattack_clp(X,Y,Pos),
        NewPos is Pos + 1,
        safe(X,Rest,NewPos).

noattack_clp(X,Y,Pos):-
        Y #\= X+Pos,
	Y #\= X-Pos.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Simple Prolog Version

%% Nqueens Problem
%%% Simple Prolog Solution that takes advantage of the fact that 
%%% no two queens can be in the same row. 

solve(N,X):- 
	coords(N,ListOfYCoordinates), 
        solution(X,ListOfYCoordinates). 

coords(0,[]):-!.
coords(N,[N|RestCoordinates]):-
	N1 is N - 1,
	coords(N1,RestCoordinates).
	 
solution([],[]). 
solution([ X | Rest], Coordinates):- 
	delete(X,Coordinates,NewCoordinates),
	solution(Rest, NewCoordinates), 
	noattack(X,Rest,1). 

noattack(_,[],_). 
noattack(X, [Y|Rest],Pos):- 
	X =\= Y + Pos,
	X =\= Y - Pos,
        NewPos is Pos + 1,
        noattack(X,Rest, NewPos).
