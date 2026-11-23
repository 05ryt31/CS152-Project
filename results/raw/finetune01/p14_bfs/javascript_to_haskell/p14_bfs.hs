import Data.List.Split (chunksOf)
 
bfs :: Eq a => a -> [(a,a)] -> Maybe Int
bfs start edges =
  let g = foldr (\(x,y) m -> insert x y $ insert y x m) [] edges
      insert x y m = M.insertWith (<>) x [y] m
      go _ [] _ = Nothing
      go seen ((x:xs):ys) d
        | x == end = Just d
        | otherwise = go (M.union seen (g M.! x)) (filter ((/= x) . head) ys) (d+1)
      go _ _ _ = Nothing
  in go M.empty (chunksOf 2 edges) 0
  where end = fst $ last edges
 
main :: IO ()
main = do
  txt <- readFile "input.txt"
  case bfs 1 $ read <$> lines txt of
    Just d -> print d
    Nothing -> putStrLn "No path found."
