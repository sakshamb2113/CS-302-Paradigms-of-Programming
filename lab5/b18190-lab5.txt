% Q1
mylength([],0).
  mylength([_|Tail],L) :- mylength(Tail,TailLen),
		            L is TailLen +1.

% Q2
myLast(X,[X]).
myLast(X,[_|Tail]) :- myLast(X,Tail).

% Q3
% (i) 
Bread = butter.
% (ii) 
false.
% (iii) 
X = butter, Y = bread.
% (iv) 
false.

% Q4
% we have removed the condition N>K
rooms([room(_,5),room(_,4),room(_,3),room(_,2),room(_,1)]).
hostel(Rooms) :- rooms(Rooms),
 member(room(akash, A), Rooms), A \= 5,
 member(room(kairav, K), Rooms), K \= 1,
 member(room(milind, M), Rooms), M \= 1, M \= 5,
 member(room(piyush, P), Rooms),
 not(adjacent(M, P)), not(adjacent(M, K)),
 member(room(nites, N), Rooms),
 print_rooms(Rooms).

adjacent(X, Y) :- X =:= Y+1.
adjacent(X, Y) :- X =:= Y-1.
print_rooms([A | B]) :- write(A), nl, print_rooms(B).
print_rooms([]).


