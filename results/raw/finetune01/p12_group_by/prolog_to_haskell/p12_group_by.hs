import Data.List (groupBy)
 
groupBy' :: Eq a => (a -> a -> Bool) -> [a] -> [[a]]
groupBy' _ [] = []
groupBy' eq (x:xs) =
  let (ys, zs) = span (eq x) xs
  in (x : ys) : groupBy' eq zs
 
main :: IO ()
main = do
  putStrLn $ unlines $
    map (\g@(x:_)-> show x ++ " " ++ show (length g)) $
      groupBy' ((==) `on` fst) . sortBy (compare `on` fst)
        [(1, 3), (1, 5), (2, 7), (2, 8), (2, 9), (3, 1)]
