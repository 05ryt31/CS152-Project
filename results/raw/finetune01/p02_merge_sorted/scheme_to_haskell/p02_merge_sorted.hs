import Data.List (sort)
 
mergeSortedLists :: Ord a => [a] -> [a] -> [a]
mergeSortedLists [] ys = ys
mergeSortedLists xs [] = xs
mergeSortedLists (x:xs) (y:ys)
  | x < y     = x : mergeSortedLists xs (y:ys)
  | otherwise = y : mergeSortedLists (x:xs) ys
 
main :: IO ()
main =
  print $
  mergeSortedLists (sort [3, 5, 7]) (sort [2, 6, 8])
