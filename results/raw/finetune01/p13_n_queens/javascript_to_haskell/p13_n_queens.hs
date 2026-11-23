nQueens :: Int -> [[Int]]
nQueens n = filter isValid [0..n-1] <*> [0..n-1]
  where
    isValid (x,y) = all (\z -> abs(x-z) /= y-x) [0..n-1]
 
main :: IO ()
main = do
  print $ length $ nQueens 8
