module Main where

import System.IO (hGetContents, stdout)
import Data.List (tails)

safe :: [Int] -> Int -> Int -> Bool
safe columns row col =
    all (\(r, c) -> c /= col && abs (c - col) /= row - r) $ zip [0..row-1] columns

count :: Int -> Int -> [Int] -> Int
count n row columns
    | row == n    = 1
    | otherwise   = sum [count n (row + 1) (columns ++ [col]) | col <- [0..n-1], safe columns row col]

main :: IO ()
main = do
    contents <- hGetContents stdin
    let n = read . head . lines $ contents
    putStr $ show (count n 0 [0] ++ replicate (n^2 - n) 0)
