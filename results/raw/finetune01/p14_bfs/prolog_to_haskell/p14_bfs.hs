import Data.List (find)
 
-- | Breadth-first search algorithm.
-- @bfs@ takes a list of nodes, a list of edges, and a start node,
-- returning either Nothing if there is no path to the target node or
-- Just n where n is the length of the shortest path to the target node.
bfs :: Eq a => [a] -> [(a,a)] -> a -> Maybe Int
bfs nodes edges start = go [start]
  where
    go [] = Nothing
    go xs =
      case find ((== start) . snd) $ concatMap (\x -> map (x,) $ filter (/= x) nodes) xs of
        Just _ -> Just 1
        Nothing ->
          let ys = concatMap (\x -> map (x,) $ filter (/= x) nodes) xs
              zs = filter (`notElem` xs) ys
          in go zs >>= return . (+1)
 
main :: IO ()
main = do
  print $ bfs [1..6] [(1,2),(2,3),(3,5),(4,5),(5,6)] 1 -- Just 1
  print $ bfs [1..6] [(1,2),(2,3),(3,5),(4,5),(5,6)] 2 -- Just 1
  print $ bfs [1..6] [(1,2),(2,3),(3,5),(4,5),(5,6)] 3 -- Just 1
  print $ bfs [1..6] [(1,2),(2,3),(3,5),(4,5),(5,6)] 4 -- Just 2
  print $ bfs [1..6] [(1,2),(2,3),(3,5),(4,5),(5,6)] 5 -- Just 2
  print $ bfs [1..6] [(1,2),(2,3),(3,5),(4,5),(5,6)] 6 -- Just 2
  print $ bfs [1..6] [(1,2),(2,3),(3,5),(4,5),(5,6)] 7 -- Nothing
