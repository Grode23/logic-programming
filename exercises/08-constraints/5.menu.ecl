:-lib(ic).
:-lib(ic_global). 

item(pizza, 12). 
item(burger, 14). 
item(kingburger, 18). 
item(platSurprise, 15).

menu(Amount, Names):-
	findall(Item, item(Item, _), Items),
	findall(Price, item(_, Price), Prices),
	length(Items, Length),
	length(Order, Length), 
	Order #:: [0..Amount],
	assign(Order, Prices, Total),
	Total #= Amount,
	labeling(Order),
	change_name(Order, Items, Names).

assign([], [], 0).

assign([Howmany|RestH], [Price|RestPrices], Total):-
	assign(RestH, RestPrices, PreviousTotal),
	Total #= (Price*Howmany) + PreviousTotal.

change_name([], [], []).

change_name([Order|RestOrders], [Item|RestItems], [Name|Names]):-
	change_name(RestOrders, RestItems, Names),
	Name = Order - Item.
