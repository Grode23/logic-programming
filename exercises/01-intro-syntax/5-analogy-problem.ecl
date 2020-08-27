% 5. Analogy Problem

figure(1, middle(triangle, square)).
figure(2, middle(circle, triangle)).
figure(3, middle(square, circle)).
figure(4, middle(square, square)).
figure(5, middle(square, triangle)).
figure(6, middle(triangle, circle)).
figure(7, middle(circle, square)).
figure(8, middle(triangle, triangle)).

figure(9, circle(down, left)).
figure(10, circle(up, left)).
figure(11, circle(down, right)).
figure(12, circle(up, right)).
figure(13, square(up, left)).
figure(14, square(down, left)).
figure(15, square(up, right)).
figure(16, square(down, right)).

relation(middle(S1, S2), middle(S2, S1), inverse).

relation(middle(S1, _), middle(S1, _), same_inside).
relation(middle(_, S1), middle(_, S1), same_outside).

relation(circle(S1, S2), square(S1, S2), location).
relation(circle(S1, S2), square(S2, S1), location).
relation(square(S1, S2), circle(S1, S2), location).
relation(square(S1, S2), circle(S2, S1), location).

analogy(F1, F2, F3, F4) :-
	figure(F1, S1),
	figure(F2, S2),
	relation(S1, S2, Rel),
	figure(F3, S3),
	figure(F4, S4),
	relation(S3, S4, Rel),
	write(Rel),
	nl.
