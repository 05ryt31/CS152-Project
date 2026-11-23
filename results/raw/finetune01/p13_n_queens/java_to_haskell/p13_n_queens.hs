nqueens :: Int -> [[(Int, Int)]]
nqueens n = filter isValid $ permutations [1..n]
  where
    isValid xs = all ok $ zip [1..] xs
    ok (i, j) = i /= j && abs(i-j) /= abs(head xs - tail xs)
      where xs = reverse $ take 2 $ dropWhile ((/=j).snd) $ zip [1..] xs
 
main = do
  print $ length $ nqueens 8
