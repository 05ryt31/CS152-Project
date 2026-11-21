import System.IO

main :: IO ()
main = do
    line <- getLine
    let result = compress line
    putStr result

compress :: String -> String
compress [] = []
compress (x:xs) = go x xs 1
  where
    go _ [] count = [x, intToDigit count]
    go prev (y:ys) count
      | prev == y = go prev ys (count + 1)
      | otherwise = x : intToDigit count : go y ys 1
