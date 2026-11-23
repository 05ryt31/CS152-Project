import Data.List (foldl')
 
-- | Checks if brackets are balanced.
balancedBrackets :: String -> Bool
balancedBrackets = null . go
  where
    go [] = []
    go (x : xs)
      | x `elem` openBrackets = x : go xs
      | otherwise =
          case go xs of
            y : ys ->
              if x == matchingBracket y
                then ys
                else x : y : ys
            [] -> x : []
    openBrackets = ['(', '[', '{']
    matchingBracket '(' = ')'
    matchingBracket '[' = ']'
    matchingBracket '{' = '}'
 
main :: IO ()
main = do
  n <- read <$> getLine
  mapM_ (\i -> putStrLn $ show i ++ ": " ++ show (balancedBrackets =<< getLine)) [1 .. n]
