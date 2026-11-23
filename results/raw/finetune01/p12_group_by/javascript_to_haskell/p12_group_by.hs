import Data.List (groupBy)
 
groupBy' :: Ord a => [a] -> [[a]]
groupBy' = groupBy (\x y -> x == y)
 
main :: IO ()
main =
  mapM_
    putStrLn
    . concatMap
      ( \xs ->
          let xss = groupBy' xs
              len = length xss
              sum = sum $ map length xss
          in if len > 1 then [show len, show sum] ++ xs else xs
      )
    . map words
    . tail
    <$> readFile "input.txt"
