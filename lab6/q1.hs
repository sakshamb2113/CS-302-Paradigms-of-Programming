import Data.Char (toLower)
type Text = [Char]
commonWords :: Int -> Text -> String
-- toLower :: Char -> Char
commonWords n = concat . map showRun . take n .
 sortRuns . countRuns . sortWords .
 words . map toLower

showRun :: (Int, Word) -> String
showRun (n,w) = w ++ ": " ++
 show n ++ "\n"

countRuns :: [Word] -> [(Int,Word)]
countRuns [] = []
countRuns (w:ws) = (1+length us,w) : countRuns vs
 where (us,vs) = span (==w) ws

sort [] = []
sort [x] = [x]
sort xs = merge (sort ys) (sort zs)
 where (ys,zs) = half xs
half xs = (take n xs, drop n xs)
 where n = length xs `div` 2
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
 | x <= y  = x : merge xs (y:ys)
 | otherwise = y : merge (x:xs) ys

null :: [a] -> Bool
null [] = True
null (x:xs) = False


sortWords :: [Word] -> [Word]
sortWords = sort
sortRuns :: [(Int,Word)] -> [(Int,Word)]
sortRuns = reverse . sort

-- commonWords 3 "to be or not to be to"
