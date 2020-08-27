:-lib(ic).
:-lib(ic_global). 

%% Weights for light on a stick

weight(10).
weight(20).
weight(30).
weight(50).
weight(60).
weight(90).
weight(100).
weight(150).
weight(250).
weight(500).


balance_lights(Weights, Total):-
	Weights = [W1, W2, W3, W4],
	findall(W, weight(W), AllWeights),
	Weights #:: AllWeights,
	5 * W1 #= 5 * W2 + 20 * W3 + 40 * W4,
	ic_global: alldifferent(Weights),
	sumlist(Weights, Total),
	labeling(Weights).
