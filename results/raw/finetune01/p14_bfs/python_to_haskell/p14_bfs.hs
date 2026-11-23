import Data.List (find)
 
-- Breadth-first search
bfs :: Eq a => (a -> [a]) -> a -> a -> Maybe Int
bfs succ start goal =
  let go [] _ = Nothing
      go ((node, depth):xs) seen
        | node == goal = Just depth
        | otherwise =
          case find (\x -> x `notElem` seen) $ succ node of
            Just next -> go ((next, depth + 1):xs) (seen ++ [node])
            Nothing   -> go xs (seen ++ [node])
  in go [(start, 0)] []
 
main :: IO ()
main = do
  putStrLn "Enter number of nodes:"
  n <- read <$> getLine
  putStrLn "Enter number of edges:"
  m <- read <$> getLine
  putStrLn "Enter edges:"
  edges <- replicateM m $ liftM2 (,) <*> read . head . words <*> read . last . words <$> getLine
  putStrLn "Enter start and end nodes:"
  [s, e] <- map read . words <$> getLine
  case bfs edges s e of
    Just d -> putStrLn $ "Distance is " <> show d
    Nothing -> putStrLn "No path found"
