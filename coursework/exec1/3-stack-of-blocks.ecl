%% Stacks of Blocks

%% a_block(blockId, height, width)
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

%% Add every width to get an upper limit 
find_biggest_width(FinalWidth):-
		findall(Width, a_block(_, _, Width), Widths), % Find all widths to sum them
		sum_widths(Widths, FinalWidth).

% If this is the last element, simply add it to the final bound
sum_widths([NumberLeft], NumberLeft).

sum_widths([First, Second|RestOfWidths], FinalWidth):-
		New is First + Second,
		sum_heights([New|RestOfWidths], FinalWidth).

stack_blocks(StackA, StackB, Height):-
	findall(Block, a_block(Block, _, _), AllBlocks),
	find_biggest_width(HighestWidth), % Find a width big enough set as upper bound for the first time
	length(StackA, 3), % Length of both stacks must be equal to 3
	length(StackB, 3), % Length of both stacks must be equal to 3
	stack_blocks(StackA, StackB, [], 0, 0, Height, HighestWidth, HighestWidth, AllBlocks). % Call stack_blocks/9
	
% Get height if it is the same for both stacks and stop recursion
stack_blocks([], [], _, Height, Height, Height, _, _, _).

% Add block to StackA
stack_blocks([Block|StackA], StackB, Visited, HeightA, HeightB, HeightToKeep, WidthA, WidthB, [Head|AllBlocks]):-
	member(Block, [Head|AllBlocks]), % Get an element from this list. Not spesifically the first one
	a_block(Block, Height, Width), % Get height and width of the selected block
	not(member(Block, Visited)), % If not visited, continue
	Width =< WidthA, % If its width is applicable (less or equal to width of A)
	NewHeight is Height + HeightA, % The new height for A
	stack_blocks(StackA, StackB, [Block| Visited], NewHeight, HeightB, HeightToKeep, Width, WidthB, AllBlocks).

% Add block to StackB
stack_blocks(StackA, [Block|StackB], Visited, HeightA, HeightB, HeightToKeep, WidthA, WidthB, [Head|AllBlocks]):-
	member(Block, [Head|AllBlocks]), % Get an element from this list. Not spesifically the first one
	a_block(Block, Height, Width), % Get height and width of the selected block
	not(member(Block, Visited)), % If not visited, continue
	Width =< WidthB, % If its width is applicable (less or equal to width of B)
	NewHeight is Height + HeightB, % The new height for B
	stack_blocks(StackA, StackB, [Block| Visited], HeightA, NewHeight, HeightToKeep, WidthA, Width, AllBlocks).

%% Find lowest stack 

find_lowest_stack(StackA, StackB, Height, Solutions):-
	init, % Initialize the counter
	lowest_stack(StackA, StackB, 1, Height), % Start find_lowest_stack/5
	get_counter(Solutions), % Variable Solutions is the counter
	!. % Don't find more solutions with minimum height

lowest_stack(StackA, StackB, BoundSoFar, BoundSoFar):-
	stack_blocks(StackA, StackB, Height), % I could use stack_blocks(StackA, StackB, BoundSoFar) if I hadn't Solutions
	increment, % Increase the amount of solutions by one
	Height = BoundSoFar. % Compare the Height I want with the Height I got

lowest_stack(StackA, StackB, BoundSoFar, Height):-
	NewBound is BoundSoFar + 1, % Increase the height I want, if it is not possible to find one
	lowest_stack(StackA, StackB, NewBound, Height).

% Functions for counter of solutions
init :- setval(counter, 0). 
increment :- incval(counter).
get_counter(V) :- getval(counter, V).
