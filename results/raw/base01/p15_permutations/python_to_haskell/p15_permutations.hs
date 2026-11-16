import System.IO

generate :: String -> [Bool] -> [Char] -> [String] -> [String]
generate letters used current out
  | length current == length letters = out ++ [""] -- This line is incorrect; it should append the current permutation to out
  | otherwise = foldl' (\acc i -> acc ++ generate letters (take i used ++ True : drop (i + 1) used) (current ++ [letters !! i]) out) [] [0..length letters - 1]

main :: IO ()
main = do
  hSetBuffering stdin NoBuffering
  hSetBuffering stdout NoBuffering
  letters <- getLine
  let results = generate (sort letters) (replicate (length letters) False) "" []
  mapM_ putStrLn results
