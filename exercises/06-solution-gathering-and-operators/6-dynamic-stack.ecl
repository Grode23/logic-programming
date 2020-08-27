:- dynamic stack/1.
stack([]).

% I create one more instance of stack with every push
pushA(Atom):-
	stack(A), % Get the first stack that exists (aka the current one)
	% Add Atom in the beginning
	% Plus, add cut to not get more than one answers
	asserta((stack([Atom|A]):-!)). 


popA(Atom):-
	retract((stack([Atom|_]):-!)).

% I remove the previous instance of the stack and I create a new one
pushB(Atom):-
	stack(A), % Get the first stack that exists (aka the current one)
	retract(stack(A)),
	% Add Atom in the beginning
	% Plus, add cut to not get more than one answers
	asserta(stack([Atom|A])). 

% I remove the existing instance of the stack and I create a new one
popB(Atom):-
	retract(stack([Atom|Rest])),
	asserta(stack(Rest)).
