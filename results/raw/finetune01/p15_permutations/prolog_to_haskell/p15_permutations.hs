import Data.List (permutations)
 
main = do
  putStrLn "Enter a word:"
  word <- getLine
  putStrLn $ unlines $ map show $ permutations word
