import Data.List (foldl')
 
-- | Checks if a string has balanced brackets.
isBalanced :: String -> Bool
isBalanced = null . go []
  where
    go :: [Char] -> String -> [Char]
    go s [] = s
    go s (x : xs)
      | x `elem` "([{"
        = go (match x : s) xs
      | otherwise
        = case s of
            y : ys
              | match y == x -> go ys xs
              | otherwise -> s
            _ -> s
 
    -- | Returns the character that should match the given opening bracket.
    match :: Char -> Char
    match '(' = ')'
    match '[' = ']'
    match '{' = '}'
    match _ = undefined
 
main :: IO ()
main =
  mapM_
    putStrLn
    [ "([]){}"
    , "[({})]"
    , "[(])"
    , "{{{{}}}}"
    , "{[()()]}"
    , "{{{{}}]}"
    ]
