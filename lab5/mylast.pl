myLast(X,[X]).
myLast(X,[_|Tail]) :- myLast(X,Tail).