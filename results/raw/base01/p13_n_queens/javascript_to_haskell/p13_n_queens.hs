module Main where

import System.IO
import Data.List

safe :: [Int] -> Int -> Int -> Bool
safe columns row col = all (\previous -> columns !! previous /= col && abs (columns !! previous - col) /= row - previous) [0..row-1]

count :: Int -> [Int] -> Int
count row columns
  | row == n    = 1
  | otherwise = sum [count (row + 1) (columns ++ [col]) | col <- [0..n-1], safe columns row col]
  where n = length columns

main :: IO ()
main = do
  hSetBuffering stdin NoBuffering
  hSetBuffering stdout NoBuffering
  input <- getContents
  let n = read $ head $ lines input
  print $ count 0 []
