:-lib(ic).
:-lib(ic_global).
:-lib(branch_and_bound).
:-lib(ic_edge_finder).

team(a, 60, 2).
team(b, 30, 1).
team(c, 50, 2).
team(d, 40, 5).

museum(Starts):-
  findall(Team, team(Team, _, _), Teams),
  findall(Visitor, team(_, Visitor, _), Visitors),
  findall(Hour, team(_, _, Hour), Hours),
  length(Teams, N),
  length(Starts, N),
  Starts #:: 0..inf,
  state_crossing_hours(Starts,Hours,Ends),
  ic:maxlist(Ends,MakeSpan),
  cumulative(Starts,Hours,Visitors,100),
  bb_min(labeling(Starts),MakeSpan,bb_options{strategy:restart}).


state_crossing_hours([],[],[]).
state_crossing_hours([S|Starts],[Hour|Hours],[E|Ends]):-
  S + Hour #= E,  
  state_crossing_hours(Starts,Hours,Ends). 
