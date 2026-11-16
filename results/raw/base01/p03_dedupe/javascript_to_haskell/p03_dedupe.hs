import Data.Set (Set)
import qualified Data.Set as Set
import System.IO

main :: IO ()
main = do
    line <- getLine
    let seen :: Set Int
        seen = Set.empty
        result :: [Int]
        result = dedupe $ map read . words $ line
    putStr $ unwords $ map show result ++ "\n"

dedupe :: Ord a => [a] -> [a]
dedupe [] = []
dedupe (x:xs) = x : dedupe (filter (/= x) xs)
