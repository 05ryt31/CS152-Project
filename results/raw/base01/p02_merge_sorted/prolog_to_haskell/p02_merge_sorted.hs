import Data.List (sort)
import System.IO

main :: IO ()
main = do
    hSetBuffering stdin NoBuffering
    hSetBuffering stdout NoBuffering
    aLine <- getLine
    bLine <- getLine
    let a = map read $ words aLine
        b = map read $ words bLine
        result = merge a b
    putStr $ unwords $ map show result ++ ["\n"]

merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
    | x <= y    = x : merge xs (y:ys)
    | otherwise = y : merge (x:xs) ys
