:-lib(ic).
:-lib(ic_global).
:-lib(ic_edge_finder).

%%% split_check/3
%%% split_check(OriginalSum,Value1,Value2)
%%% Succeeds if Value1 + Value 2 = OriginalSum and 
%%% numbers Value1 and Value2 do not contain any digits.
split_check(OriginalSum,Value1,Value2):-
	number_of_digits(OriginalSum,Len),
	% numbers consist of digits. The maximum 
	% number of digits is the number of digits of the 
	% Original Sum.
	length(Digits1,Len),
	length(Digits2,Len),
	append(Digits1,Digits2,Digits),
	Digits #:: [0..3,5..9],
	% Evaluate a sequence of digits as an integer.
	evaluate(Digits1,Value1),
	evaluate(Digits2,Value2),
	Value1 #>0, Value2 #> 0, 
	Value1 + Value2 #= OriginalSum,
	% labeling on the digits.
	labeling(Digits).
 
%%% evaluate/2
%%% evaluate(Digits,Value)
%%% Succeeds if Value is the integer formed by the 
%%% sequence of Digits.
evaluate(Digits,Value):-
	evaluate(Digits,_,Value).

%%% evaluate/3
%%% Auxiliary predicate to evaluate/2
%%% The second argument is the position of the digit.
evaluate([],0,0).
evaluate([D|RestD],Exp,Value):-
	evaluate(RestD,RExp,RestValue),
	Exp is RExp + 1,
	F is (10^RExp),
	Value #= D * F + RestValue.
