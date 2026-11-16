import Data.List (isInfixOf, isPrefixOf, isSuffixOf, nub)
import System.IO (hGetContents, stdout)

main :: IO ()
main = do
    input <- hGetContents stdin
    let nums = map read . words $ input
        uniqueNums = nub nums
    putStr $ unwords $ map show uniqueNums
