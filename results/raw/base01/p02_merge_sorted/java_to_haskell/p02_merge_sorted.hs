module Main where

import Data.List (intercalate)
import Text.Read (readMaybe)

parse :: String -> [Int]
parse line = case words line of
  [] -> []
  xs -> map readMaybe xs >>= catMaybes

merge :: [Int] -> [Int] -> [Int]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
  | x <= y    = x : merge xs (y:ys)
  | otherwise = y : merge (x:xs) ys

main :: IO ()
main = do
  a <- parse <$> getLine
  b <- parse <$> getLine
  let merged = merge a b
  putStrLn $ intercalate " " (map show merged)
