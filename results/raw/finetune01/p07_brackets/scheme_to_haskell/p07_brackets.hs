import Data.List (foldl')
 
-- | Checks if a string is balanced.
isBalanced :: String -> Bool
isBalanced = null . go []
  where
    go :: [Char] -> String -> [Char]
    go s [] = s
    go s (x : xs)
      | x == '(' || x == '[' || x == '{' = go (x : s) xs
      | otherwise =
          case s of
            [] -> s
            y : ys ->
              if matching y x then go ys xs else s
 
-- | Checks if two characters are matching brackets.
matching :: Char -> Char -> Bool
matching '(' ')' = True
matching '[' ']' = True
matching '{' '}' = True
matching _ _     = False
 
-- | Tests whether a list of strings is balanced.
testBalancing :: [String] -> [Bool]
testBalancing = map isBalanced
 
-- | Prints the results of balancing a list of strings.
printResults :: [String] -> IO ()
printResults = mapM_ printResult . testBalancing
  where
    printResult b = putStrLn $ if b then "Yes" else "No"
 
main :: IO ()
main = do
  n <- readLn
  lines <- replicateM n getLine
  printResults lines
