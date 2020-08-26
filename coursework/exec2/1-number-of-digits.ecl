:-lib(ic).
:-lib(ic_global).
:-lib(ic_edge_finder).

%%% number_of_digits/2
%%% number_of_digits(Number,Digits)
%%% Succeeds if Digits is the number (length) of integer 
%%% Number
number_of_digits(Number,Digits):-
	number_string(Number,Str),
	string_length(Str,Digits).

% Split a check with number 4
% Into 2 checks without number 4
split_check(Amount, Check1, Check2):-
	% Initiliaze values
	[Check1, Check2] #:: [1..Amount-1],
	Check1 + Check2 #= Amount,
	% Give values
	labeling([Check1, Check2]),
	% Get the amount of digits in the current number
	number_of_digits(Check1, Digits1),
	number_of_digits(Check2, Digits2),
	% Check if contraints are true
	contraints(Check1, Digits1),
	contraints(Check2, Digits2).

contraints(_, 0):- !.

contraints(Check, Digits):-
	Divisor is 10^(Digits - 1),
	Quotient is Check // Divisor,
	Quotient \= 4,
	NewCheck is mod(Check, Divisor),
	NewDigits is Digits - 1,
	contraints(NewCheck, NewDigits).

