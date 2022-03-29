:- abolish_all_tables.
:- table dfs/2, dfs/3, copies/2, ancestor/2.

dfs(A, X) :- alloc(A,X).
dfs(A, X) :- load(A,B,Field), dfs(B,Field,X).
dfs(A, X) :- copy(A,B), dfs(B,X).
dfs(A, Field, X) :- store(A,Field,B), dfs(B, X).
dfs(A, Field, X) :- copies(A,B), store(B,Field,C),dfs(C,X).
dfs(A, Field, X) :- ancestor(A,B), store(B,Field,C),dfs(C,X).


pointees(A,L) :- setof(X,dfs(A,X),L).


fieldpointeesUtil(A,[H],Y) :-  copies(A,B), ancestor(B,C), store(C,H,F), dfs(F,Y).
fieldpointeesUtil(A,[H|T],Y) :- copies(A,B), ancestor(B,C), store(C,H,X), fieldpointeesUtil(X,T,Y).
fieldpointeesUtil(A,[H],Y) :-  ancestor(A,B), store(B,H,F), dfs(F,Y).
fieldpointeesUtil(A,[H|T],Y) :- ancestor(A,B), store(B,H,X), fieldpointeesUtil(X,T,Y).
fieldpointees(A,Fields,L) :- setof(Y,fieldpointeesUtil(A,Fields,Y),L).

copies(A, X) :- X = A.
copies(A, X) :- copy(A,B), copies(B,X).
copies(A, X) :- copy(A,X).
copies(A, X) :- load(A,B,Field), ancestor(B,C), store(C,Field,X).
copies(A, X) :- load(A,B,Field), ancestor(B,C), store(C,Field,D), copies(D,X).

ancestor(A, X) :- X = A.
ancestor(A, X) :- copy(X, A).
ancestor(A, X) :- copy(B, A), ancestor(B,X).
ancestor(A, X) :- store(C,Field,A), ancestor(B,C), load(X,B,Field).
ancestor(A, X) :- store(C,Field,A), ancestor(B,C),load(D,B,Field), ancestor(D,X).


alloc(a,o1).
alloc(b,o2).
alloc(c,o3).
alloc(d,o4).
copy(b,a).
load(b,c,f).
store(c,f,d).