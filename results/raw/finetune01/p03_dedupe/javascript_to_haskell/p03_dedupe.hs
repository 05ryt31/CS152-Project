import Data.List (group)
 
-- remove duplicates in order
removeDups :: Eq a => [a] -> [a]
removeDups = map head . group
 
main :: IO ()
main = do
  putStrLn $ unwords $ removeDups "the quick brown fox jumps over the lazy dog"
