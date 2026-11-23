import Data.List.Split (chunksOf)
 
bfs :: [Int] -> [(Int, Int)] -> Int -> Int -> Maybe Int
bfs nodes edges start end =
  let graph = foldr (\(a, b) g -> (a, b):g ++ (b, a):g) [] edges
      go _ [] _ _ = Nothing
      go seen ((x, y):xs) q d
        | x == end || y == end = Just $ max d (max x y)
        | otherwise =
          let ns = filter (\n -> n /= x && n /= y && not (elem n seen))
              xs
          in case ns of
               [] -> go (x : y : seen) xs q d
               _ ->
                 let qs = chunksOf 2 $ concatMap (\n -> [n, x]) ns ++
                           concatMap (\n -> [n, y]) ns
                 in go (x : y : seen) xs qs (d + 1)
  in go [] edges [start] 0
 
main :: IO ()
main = do
  print $
    bfs [1 .. 6]
      [(1, 3), (1, 5), (2, 3), (2, 4), (3, 4), (3, 5), (4, 5)]
      1
      4
  print $
    bfs [1 .. 6]
      [(1, 3), (1, 5), (2, 3), (2, 4), (3, 4), (3, 5), (4, 5)]
      1
      6
