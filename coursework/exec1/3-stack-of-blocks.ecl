%% Stacks of Blocks

%Name | Height | Width
a_block(b1,2,4).
a_block(b2,1,3).
a_block(b3,3,3).
a_block(b4,1,2).
a_block(b5,4,1).
a_block(b6,2,1).
a_block(b7,5,3).
a_block(b8,5,2).
a_block(b9,4,4).
a_block(b10,2,3).

stack_blocks(StackA, StackB, Height):-
	findall(Width, a_block(_, _, Width), Widths),
	sumlist(Widths, MaxWidth),

	LengthOfStacks is 3,
	length(StackA, LengthOfStacks),
	length(StackB, LengthOfStacks),

	build_stack(StackA, [], MaxWidth, Height),
	build_stack(StackB, StackA, MaxWidth, Height).


build_stack([], _, _, 0).

build_stack([Name|Stack], NotAllowed, StandardWidth, Height):-
	a_block(Name, CurrHeight, Width),
	Width =< StandardWidth,
	not(member(Name, NotAllowed)),

	build_stack(Stack, [Name|NotAllowed], Width, PrevHeight),
	Height is PrevHeight + CurrHeight.

find_lowest_stack(StackA, StackB, Height, Solutions):-
	setof((Hght, StA, StB),stack_blocks(StA, StB, Hght),[(Height, StackA, StackB)|List]), 
	length(List,Solutions).
