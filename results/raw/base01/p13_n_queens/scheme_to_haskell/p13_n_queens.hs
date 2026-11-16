import System.IO

-- Function to check if placing a queen at column `col` is safe
safe :: [Int] -> Int -> Bool
safe queens col = all (\(r, c) -> r /= row && abs (r - row) /= abs (c - col)) $ zip [0..] queens
  where row = length queens

-- Recursive function to count the number of solutions
count :: Int -> [Int] -> Int
count n queens
  | length queens == n = 1
  | otherwise = sum [count n (queens ++ [col]) | col <- [0..n-1], safe queens col]

-- Main function to read input and print the result
main :: IO ()
main = do
  hSetBuffering stdin NoBuffering
  hSetBuffering stdout NoBuffering
  n <- readLn
  print $ count n []
