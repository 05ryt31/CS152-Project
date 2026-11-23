merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
  | x <= y = x : merge xs (y:ys)
  | otherwise = y : merge (x:xs) ys
 
-- example usage:
-- *Main> merge [1,3,5,7] [2,4,6,8]
-- [1,2,3,4,5,6,7,8]
