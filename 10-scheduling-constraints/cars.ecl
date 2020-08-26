%%% Libraries Required.
:-use_module(library(ic)).
:-use_module(library(branch_and_bound)). 
:-use_module(library(ic_edge_finder)).

%%% car(Name, Weight, Speed) 
car(alpha, 10, 4).
car(beta, 13,5).
car(gamma, 8, 3).
car(delta, 5, 4).
car(ephilon, 7, 1).
car(zita, 9, 3).
car(eta, 11, 6).

solve(Starts,MakeSpan):-
  findall(C,car(C,_,_),Cars),
  findall(W,car(_,W,_),Weights),
  findall(S,car(_,_,S),Speeds),
  length(Cars,N),
  length(Starts,N), %% My vars
  Starts #:: 0..inf,  
  state_crossing_times(Starts,Speeds,Ends),
  ic:maxlist(Ends,MakeSpan),
  cumulative(Starts,Speeds,Weights,20),
  bb_min(labeling(Starts),MakeSpan,bb_options{strategy:restart}),
  pretty_print(Cars,Starts,Ends).

state_crossing_times([],[],[]).
state_crossing_times([S|Starts],[Sp|Speeds],[E|Ends]):-
  S + Sp #= E,  
  state_crossing_times(Starts,Speeds,Ends). 

pretty_print([],[],[]).
pretty_print([C|Cars],[S|Starts],[E|Ends]):-
  write([car,C,leaves,S,until,E]),nl,
  pretty_print(Cars,Starts,Ends).
