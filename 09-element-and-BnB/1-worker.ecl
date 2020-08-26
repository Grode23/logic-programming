:-use_module(library(ic)).
:-use_module(library(ic_global)).
:-use_module(library(branch_and_bound)).

worker(1,[4,1,3,5,6],[30,8,30,20,10]). 
worker(2,[6,3,5,2,4],[140,20,70,10,90]). 
worker(3,[8,4,5,7,10],[60,80,10,20,30]). 
worker(4,[3,7,8,9,1],[30,40,10,70,10]). 
worker(5,[7,1,5,6,4],[40,10,30,20,10]). 
worker(6,[8,4,7,9,5],[20,100,130,220,50]). 
worker(7,[5,6,7,4,10],[30,30,30,20,10]). 
worker(8,[2,6,10,8,3],[50,40,20,10,60]). 
worker(9,[1,3,10,9,6],[50,40,10,20,30]). 
worker(10,[1,2,7,9,3],[20,20,30,40,50]). 

solve(Jobs, Cost):-
	findall(W, worker(W, _, _), Workers),
	constrain_workers(Workers, Jobs, Costs),
	ic_global:alldifferent(Jobs),
	sumlist(Costs, Cost),
	bb_min(labeling(Jobs), Cost, _).

constrain_workers([], [], []).

constrain_workers([W|RestW], [J|RestJ], [C|RestC]):-
	worker(W, ListJobs, ListCosts),
	element(I, ListJobs, J),
	element(I, ListCosts, C),
	constrain_workers(RestW, RestJ, RestC).

