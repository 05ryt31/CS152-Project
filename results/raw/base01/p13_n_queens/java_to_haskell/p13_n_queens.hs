module Main where

import Control.Monad (forM_)
import Data.List (tails)
import System.IO (hGetContents, stdin)

-- Check if placing a queen at (row, col) is safe
safe :: [Int] -> Int -> Int -> Bool
safe cols row col = all (\(r, c) -> abs (r - row) /= abs (c - col) && c /= col) $ zip [0..row-1] cols

-- Count the number of solutions for N Queens problem
count :: Int -> Int -> [Int] -> Int
count n row cols
  | row == n    = 1
  | otherwise = sum [count n (row + 1) (cols ++ [col]) | col <- [0..n-1], safe cols row col]

-- Main function to read input and print the result
main :: IO ()
main = do
  input <- hGetContents stdin
  let n = read . head . lines $ input
  print $ count n 0 []
