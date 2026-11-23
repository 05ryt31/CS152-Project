import Data.List (group)
 
encode :: String -> [(Int, Char)]
encode = map (length &&& head) . group
 
main = interact $ unwords . map show . encode
