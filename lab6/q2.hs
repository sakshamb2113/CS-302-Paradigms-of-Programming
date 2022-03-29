myTake :: Int -> [a] -> [a]
myTake 0 _ = []
myTake _ [] = []
myTake n (y : ys) | n > 0 = y : myTake (n - 1) ys
myTake _ _ = error "invalid args"

myDrop :: Int -> [a] -> [a]
myDrop 0 (y:ys) = (y:ys)
myDrop _ [] = []
myDrop n (_:ys) | n > 0 = myDrop (n-1) ys
myDrop _ _ = error "invalid args"