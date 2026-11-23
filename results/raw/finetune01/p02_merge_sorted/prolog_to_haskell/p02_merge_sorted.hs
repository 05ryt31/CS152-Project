import Data.List (intercalate)
 
mergeSortedLists :: Ord a => [a] -> [a] -> [a]
mergeSortedLists [] ys = ys
mergeSortedLists xs [] = xs
mergeSortedLists (x:xs) (y:ys)
  | x <= y = x : mergeSortedLists xs (y:ys)
  | otherwise = y : mergeSortedLists (x:xs) ys
 
main :: IO ()
main =
  interact $
  intercalate "\n" . fmap (unwords . show . mergeSortedLists <*> read) . lines
