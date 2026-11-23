import Data.List (groupBy, sortBy)
import Data.Function (on)
 
-- Task 1
groupByLength :: [String] -> [(Int, String)]
groupByLength = map (\s -> (length s, s)) . groupBy ((==) `on` length)
 
-- Task 2
groupByLength' :: [String] -> [(Int, [String])]
groupByLength' = map (\s -> (length s, s)) . groupBy ((==) `on` length) . sortBy (compare `on` length)
 
-- Task 3
groupByLength'' :: [String] -> [(Int, [String])]
groupByLength'' = map (\s -> (length s, s)) . groupBy ((==) `on` length) . sortBy (flip compare `on` length)
 
-- Task 4
groupByLength''' :: [String] -> [(Int, [String])]
groupByLength''' = map (\s -> (length s, s)) . groupBy ((==) `on` length) . sortBy (flip compare `on` length) . reverse
 
main :: IO ()
main = do
  print $ groupByLength ["a", "aa", "aaa", "b", "bb"]
  print $ groupByLength' ["a", "aa", "aaa", "b", "bb"]
  print $ groupByLength'' ["a", "aa", "aaa", "b", "bb"]
  print $ groupByLength''' ["a", "aa", "aaa", "b", "bb"]
