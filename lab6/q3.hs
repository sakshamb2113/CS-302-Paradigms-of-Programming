import Data.Compositions (Snoc)
data List a = Nil | Snoc (List a) a 
let { toListh :: [a] -> List a ; toListh [] = Nil ; toListh (h:t) = Snoc (toListh t) h }
let { toList :: [a] -> List a ; toList a = toListh (rev a)}
let { fromList :: List a -> [a] ; fromList (Snoc Nil b) = [b] ; fromList (Snoc a b) = (fromList a)++[b]}
let{ rev [] = []; rev (x:xs) = rev xs ++ [x]}
let { scar::List a->a; scar (Snoc a b) = b }
let { scdr::List a->List a; scdr (Snoc a b) = a }

scar :: List a-> a
scar (Snoc a) =