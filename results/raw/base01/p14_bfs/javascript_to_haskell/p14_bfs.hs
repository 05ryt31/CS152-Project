import Data.List (find)
import Data.Maybe (fromJust)

main :: IO ()
main = do
    contents <- getContents
    let lines = lines contents
        [n, m] = map read . words $ lines !! 0
        graph = buildGraph n m (tail lines)
        [start, target] = map read . words $ lines !! (m + 1)
        distance = bfsDistance graph start
    print $ distance !! target

buildGraph :: Int -> Int -> [String] -> [[Int]]
buildGraph n m edges = foldl addEdge (replicate (n + 1) []) edges
  where
    addEdge g (e:es) = let [u, v] = map read . words $ e in g & (!! u) %~ (v :)
                      & (!! v) %~ (u :)

bfsDistance :: [[Int]] -> Int -> [Int]
bfsDistance graph start = go [start] (-1 : repeat (-1))
  where
    go [] _ = []
    go (node:rest) dists
      | node == length dists - 1 = dists
      | otherwise = let newDists = updateDist dists node
                        newQueue = filter (`notElem` rest) (graph !! node ++ rest)
                    in go newQueue newDists
    updateDist ds idx = take idx ds ++ [(ds !! idx) + 1] ++ drop (idx + 1) ds
