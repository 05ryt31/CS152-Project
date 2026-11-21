import System.IO
import Data.List

main :: IO ()
main = do
    line <- getLine
    let n = read line :: Int
    print $ length $ solveNQueens n

solveNQueens :: Int -> [[Int]]
solveNQueens n = filter isValid [perm | perm <- permutations [0..n-1]]

isValid :: [Int] -> Bool
isValid cols = all safeDiags cols && all safeCols cols
  where
    safeDiags cols = all (\(i, j) -> abs (i - j) /= abs (cols !! i - cols !! j)) [(i, j) | i <- [0..length cols - 2], j <- [i+1..length cols - 1]]
    safeCols cols = all (/=) cols
