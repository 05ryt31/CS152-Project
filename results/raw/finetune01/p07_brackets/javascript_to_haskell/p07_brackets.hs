import Data.List (elemIndex)
 
-- Returns Just True if brackets are balanced, otherwise Nothing
isBalanced :: String -> Maybe Bool
isBalanced s = case go [] s of
                  [] -> Just True
                  _  -> Just False
  where
    go :: [Char] -> String -> [Char]
    go xs [] = xs
    go xs (x : xs')
      | x == '(' || x == '[' || x == '{' = go (x : xs) xs'
      | otherwise =
          case elemIndex x "({[" of
            Just i -> case elemIndex (xs !! i) ")}]" of
                        Just j -> go (take i xs ++ drop (i+1) xs) xs'
                        Nothing -> []
            Nothing -> []
 
main :: IO ()
main = do
  txt <- getContents
  let inputs = tail $ lines txt
  mapM_ (\s -> print $ isBalanced s) inputs
