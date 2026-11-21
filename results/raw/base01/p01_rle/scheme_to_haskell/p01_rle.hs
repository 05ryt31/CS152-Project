import Data.Char (intToDigit)
import System.IO

main :: IO ()
main = do
    line <- getLine
    let encoded = encode $ map ord line
    putStr $ concatMap show encoded ++ "\n"

encode :: [Int] -> [[Int]]
encode [] = []
encode xs = go xs where
    go [] = []
    go ys@(y:_) = let (same, rest) = span (== y) ys in (length same : [y]) : go rest
