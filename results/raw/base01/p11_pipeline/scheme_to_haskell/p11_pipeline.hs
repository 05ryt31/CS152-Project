import Data.List (splitAt, intersperse)
import System.IO (hGetContents, hPutStr, stdin, stdout)
import Control.Monad (forever, when)

-- Convert a list of strings to a list of numbers
numbers :: String -> [Int]
numbers line = if null line then [] else map read $ words line

-- Sum a list of numbers
sumValues :: [Int] -> Int
sumValues = sum

-- Find the maximum value in a list of numbers
maximumValue :: [Int] -> Int
maximumValue = maximum

-- Keep elements in a list that satisfy a predicate
keep :: (a -> Bool) -> [a] -> [a]
keep _ [] = []
keep pred (x:xs) = if pred x then x : keep pred xs else keep pred xs

-- Apply a stage transformation to a list of numbers based on the given parts
applyStage :: [Int] -> [String] -> [Int]
applyStage values parts = case parts of
    ["map", "add", amount] -> map (+ read amount) values
    ["map", "mul", amount] -> map (* read amount) values
    ["filter", "even"] -> filter even values
    ["filter", "odd"] -> filter odd values
    ["filter", "gt", amount] -> filter (> read amount) values
    ["sum"] -> [sumValues values]
    _ -> [maximumValue values]

-- Process the pipeline for a given number of stages
pipeline :: Int -> [Int] -> IO ()
pipeline k values = go 0 values
  where
    go i result
      | i == k = do
          when (not . null $ result) $ do
              hPutStr stdout $ show (head result)
              hPutStr stdout $ concatMap (" " ++) (map show (tail result))
              hPutStrLn stdout ""
          return ()
      | otherwise = do
          line <- hGetLine stdin
          let parts = words line
          let newResult = applyStage result parts
          go (i + 1) newResult

-- Main function to read input and process the pipeline
main :: IO ()
main = do
    line <- hGetLine stdin
    let values = numbers line
    k <- readLn
    pipeline k values
