import Data.List (permutations)
import System.IO

main :: IO ()
main = do
    contents <- getContents
    let sortedLetters = sort $ lines contents
    let perms = permutations sortedLetters
    putStr $ unlines perms
