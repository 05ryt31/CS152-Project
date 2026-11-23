nQueens :: Int -> [[(Int, Int)]]
nQueens n =
  filter isValid $ map (\x -> zip x [1..]) $ permutations [1..n]
  where
    isValid xs = all ok $ zip xs [1..]
    ok (x, y) = null [z | z <- xs, conflict (x,y) z]
    conflict (x1, y1) (x2, y2) = x1 == x2 || y1 == y2 || abs (y1 - y2) == abs (x1 - x2)
 
main :: IO ()
main = do
  putStrLn "Enter board size:"
  n <- read <$> getLine
  let solutions = nQueens n
  putStrLn $ "Number of solutions: " ++ show (length solutions)
  putStrLn $ "First solution:" ++ show (head solutions)
