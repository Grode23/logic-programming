% Transitions of s1
transitions(s1, s2, 10).
transitions(s1, s3, 20).
transitions(s1, s6, 50).

% Transitions of s2
transitions(s2, s3, 10).
transitions(s2, s4, 20).

% Transitions of s3
transitions(s3, s4, 10).
transitions(s3, s5, 20).

% Transitions of s4
transitions(s4, s5, 10).
transitions(s4, s6, 20).

% Transitions of s5
transitions(s5, s6, 10).

coins_to_insert(Finish, Finish, []).

coins_to_insert(Start, Finish, [Coin|RestCoins]):-
	transitions(Start, NewStart, Coin),
	coins_to_insert(NewStart, Finish, RestCoins).

total_combinations(Amount):-
	findall(
		X, 
		(
			coins_to_insert(s1, s6, X)
		),
		Combinations),
	length(Combinations, Amount).
