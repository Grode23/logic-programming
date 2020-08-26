:-op(500,yfx,and).
:-op(500,yfx,or).
:-op(500,yfx,nor).
:-op(500,yfx,nand).
:-op(500,yfx,xor).

:-op(400,fy,--).
:-op(600,xfx,==>).

--Arg1:-not(Arg1).
 
Arg1 ==> Arg2 :- Arg1 or --Arg2.

Arg1 and Arg2 :- Arg1, Arg2.

Arg1 or _Arg2 :- Arg1.
_Arg1 or Arg2 :- Arg2.
 
Arg1 xor Arg2 :- Arg1, --Arg2.
Arg1 xor Arg2 :- --Arg1, Arg2.

Arg1 nor Arg2 :- --(Arg1 or Arg2).
Arg1 nand Arg2 :- --(Arg1 and Arg2).

%Boolean values
t. 
f:-!,fail.

model(Expr):-
	term_variables(Expr, Vars),
	assign(Vars),
	call(Expr).


assign([]).

assign([t|Tail]):-	
	assign(Tail).

assign([f|Tail]):-	
	assign(Tail).

% theory/1

theory([]).

theory([Expr|RestExprs]):-
	model(Expr),
	theory(RestExprs).
