import Data.List (group)
 
encode :: String -> [(Char, Int)]
encode = map (\x -> (head x, length x)) . group
 
main = print $ encode "aaabbcccc"
