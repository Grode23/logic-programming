:-use_module(library(ic)).
:-use_module(library(ic_global)).
:-use_module(library(branch_and_bound)).

%  Name | storage | price
provider(a,[0,750,1000,1500],[0,10,13,17]).
provider(b,[0,500,1250,2000],[0,8,12,22]).
provider(c,[0,1000,1750,2000],[0,15,18,25]).
provider(d,[0,1000,1500,1750],[0,13,15,17]).

space(Gigas, Cost):-
	findall(Provider , provider(Provider, _, _), Providers),
	assign(Providers, Gigas, Costs),
	sumlist(Gigas, Giga),
	sumlist(Costs, Cost),
	Giga #> 3600,
	Giga #< 4600,
	bb_min(labeling(Gigas), Cost, _).

assign([], [], []).

assign([Provider|RestProviders], [Giga|RestGigas], [Cost|RestCosts]):-
	provider(Provider, AllGiga, AllCost),
	element(Index, AllGiga, Giga),
	element(Index, AllCost, Cost),
	assign(RestProviders, RestGigas, RestCosts).
