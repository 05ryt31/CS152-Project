import Data.List (permutations)
 
-- check if two queens threaten each other
threats :: [(Int, Int)] -> Bool
threats [] = False
threats ((x,y):xs) = any (\(a,b) -> x == a || y == b || abs(x-a) == abs(y-b)) xs || threats xs
 
-- all permutations of columns for given board size
cols :: Int -> [[Int]]
cols n = filter (not . threats) $ permutations [1..n]
 
-- number of solutions for given board size
numSolutions :: Int -> Int
numSolutions n = length $ cols n
 
main = do
  print $ numSolutions 8 -- 92
  print $ numSolutions 15 -- 724
  print $ numSolutions 20 -- 73712
