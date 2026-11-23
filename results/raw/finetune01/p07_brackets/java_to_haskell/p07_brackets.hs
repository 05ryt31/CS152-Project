import Data.List (foldl')
 
-- | Checks if brackets in string are balanced.
isBalanced :: String -> Bool
isBalanced = null . go []
  where
    go []     ('(' : xs) = go [(')' , 1)] xs
    go []     ('[' : xs) = go [(']' , 2)] xs
    go []     ('{' : xs) = go [('}', 3)] xs
    go []     _          = False
    go ((c, n):xs) (x : xs')
      | x == c    = go xs' xs'
      | otherwise = case n of
                      1 -> go ((')', 1):xs) xs'
                      2 -> go ((']', 2):xs) xs'
                      3 -> go (('}', 3):xs) xs'
                      _ -> error "impossible"
    go _        []       = True
 
main :: IO ()
main =
  do print $ isBalanced "()"
     print $ isBalanced "(]"
     print $ isBalanced "{[()]}"
     print $ isBalanced "{[(])}"
     print $ isBalanced "{{{{}}}}"
