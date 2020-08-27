:-use_module(library(ic)).
:-use_module(library(ic_global)).
:-use_module(library(branch_and_bound)).

student(alex,[4,1,3,5,6]). 
student(nick,[6,3,5,2,4]). 
student(jack,[8,4,5,7,10]). 
student(helen,[3,7,8,9,1]). 
student(maria,[7,1,5,6,4]). 
student(evita,[8,4,7,9,5]). 
student(jacky,[5,6,7,4,10]). 
student(peter,[2,6,10,8,3]). 
student(john,[1,3,10,9,6]). 
student(mary,[1,6,7,9,10]). 

thesis(Students, Cost):-
	findall((Student, _), student(Student, _), Students),
	preferences(Students, Preferences, Cost),
	ic_global: alldifferent(Preferences),
	bb_min(labeling(Preferences), Cost, _).

preferences([], [], 0).

preferences([(Student, Preference)|RestStudents], [Preference|RestPreference], Cost):-
	student(Student, Preferences),
	Preference #:: Preferences,
	element(IndexOfDecision, Preferences, Preference),
	preferences(RestStudents, RestPreference, PrevCost),
	Cost #= PrevCost + IndexOfDecision.
