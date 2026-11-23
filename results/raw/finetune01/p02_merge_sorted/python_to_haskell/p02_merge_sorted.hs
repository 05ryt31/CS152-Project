mergeSortedLists :: Ord a => [a] -> [a] -> [a]
mergeSortedLists [] ys = ys
mergeSortedLists xs [] = xs
mergeSortedLists (x:xs) (y:ys)
  | x <= y = x : mergeSortedLists xs (y:ys)
  | otherwise = y : mergeSortedLists (x:xs) ys
 
-- example usage:
-- *Main> mergeSortedLists [1,3,5,7] [2,4,6,8]
-- [1,2,3,4,5,6,7,8]
