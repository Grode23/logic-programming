:-use_module(library(ic)).
:-use_module(library(ic_global)).
:-use_module(library(branch_and_bound)).

box(1,140). 
box(2,200). 
box(3,450). 
box(4,700). 
box(5,120). 
box(6,300). 
box(7,250). 
box(8,125). 
box(9,600). 
box(10,650).

load_trucks(Truck1, Load1, Truck2, Load2):-
	
	findall(Weight, box(_, Weight), Weights),
	
	length(Truck1, 3),
	length(Truck2, 4),

	assign_loads(Truck1, Weights, Load1),
	assign_loads(Truck2, Weights, Load2),

	Load1 #=< 1200,
	Load2 #=< 1350,

	append(Truck1,Truck2,Trucks),
	ic_global:alldifferent(Trucks),
	
	Load #= (1200 + 1350) - (Load1 + Load2),

	bb_min(labeling(Trucks), Load, _).


assign_loads([], _, 0).

assign_loads([Box|Boxes], Weights, Load):-
	element(Box, Weights, Weight),
	assign_loads(Boxes, Weights, PrevLoad),
	Load #= PrevLoad + Weight.

% If indexes of boxes were different, I would use this one
%% assign_loads([Box|Boxes], Weights, Load):-
%% 	element(Index, Weights, Weight),
%% 	element(Index, Weights, Box),
%% 	assign_loads(Boxes, Weights, PrevLoad),
%% 	Load #= PrevLoad + Weight.
