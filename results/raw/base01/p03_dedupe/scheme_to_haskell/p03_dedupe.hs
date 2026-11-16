import Data.List (nub, words)
import System.IO

main :: IO ()
main = do
    input <- getContents
    let numbers = map read . words $ input
    let deduped = nub numbers
    putStr $ unwords $ map show deduped ++ ["\n"]
