mylength([],0).
  mylength([_|Tail],L) :- mylength(Tail,TailLen),
		            L is TailLen +1.