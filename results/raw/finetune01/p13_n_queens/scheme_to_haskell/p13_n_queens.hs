import Data.List (permutations)
 
-- check if two queens threaten each other
threaten :: (Int, Int) -> (Int, Int) -> Bool
threaten (x1,y1) (x2,y2) = x1 == x2 || y1 == y2 || abs(x1-x2) == abs(y1-y2)
 
-- check if a queen placement is valid
valid :: [(Int, Int)] -> Bool
valid [] = True
valid (q:qs) = all (\q' -> not $ threaten q q') qs && valid qs
 
-- count the number of valid placements
nQueens :: Int -> Int
nQueens n = length $ filter valid $ permutations [1..n]
 
main = print $ nQueens 8
