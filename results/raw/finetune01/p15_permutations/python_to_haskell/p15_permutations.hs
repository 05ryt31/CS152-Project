import Data.List (permutations)
 
main = do
  putStrLn $ unwords $ permutations "abc"
