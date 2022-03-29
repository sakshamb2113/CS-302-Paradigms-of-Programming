:- abolish_all_tables.
:- table dfs/2, dfs/3, copies/2.
/*tree based traversing*/

/*alloc is base case*/
/*!!!reverse copy case causes cycles!!!*/
dfs(A, X) :- alloc(A,X).
dfs(A, X) :- load(A,B,Field), dfs(B,Field,X).
dfs(A, X) :- copy(A,B), dfs(B,X).
dfs(A, Field, X) :- store(A,Field,B), dfs(B, X).
dfs(A, Field, X) :- copy(A,B), dfs(B,Field,X).
dfs(A, Field, X) :- copy(B,A), dfs(B,Field,X).


pointees(A,L) :- setof(X,dfs(A,X),L).

/*difference between pointees and field pointees-*/
/*-> get current and its copies
->if any has store statement with given field proceed to use that variable with recursive call
*/
fieldpointeesUtil(A,[H],Y) :-  copies(A,B), store(B,H,F), dfs(F,Y).
fieldpointeesUtil(A,[H|T],Y) :- copies(A,B), store(B,H,X), fieldpointeesUtil(X,T,Y).
fieldpointees(A,Fields,L) :- setof(Y,fieldpointeesUtil(A,Fields,Y),L).
/*either A will have field or its copy will have*/
/*check field presence by store()*/
copies(A, X) :- X = A.
copies(A, X) :- copy(A,B), copies(B,X).
copies(A, X) :- copy(A,X).
copies(A, X) :- load(A,B,Field), store(B,Field,X).
copies(A, X) :- load(A,B,Field), store(B,Field,C), copies(C,X).
/*good need to take notice that reverse is not being taken into account*/
%copies(A, X) :- store(B,Field,A),load(X,B,Field). 
copies(A, X) :- copy(X,A).


/*paste facts below*/
copy(1,2).
%load(c,e,f).
%store(e,f,b).
copy(c,b).
load(a,b,f).
store(c,f,d).
alloc(a,o1).
alloc(b,o2).
alloc(c,o3).
alloc(d,o4).
alloc(e,o5).