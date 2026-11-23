import Data.List (find)
 
-- A simple representation of a graph using adjacency lists.
data Graph = Graph { vertices :: [Int], edges :: [(Int, Int)] }
 
-- Breadth-first search algorithm.
bfs :: Eq a => a -> [a] -> [[a]]
bfs _ [] = []
bfs x xs =
  let ys = filter (/=x) xs
  in if null ys then [] else [x]:bfs x ys
 
-- Find the shortest path from a given vertex to all other vertices.
shortestPaths :: Eq a => a -> [a] -> [[a]]
shortestPaths x xs = bfs x xs
 
-- Compute the distance from a given vertex to another vertex.
distance :: Eq a => a -> a -> [a] -> Maybe Int
distance x y xs =
  case find (elem y) $ shortestPaths x xs of
    Just path -> Just $ length path - 1
    Nothing   -> Nothing
 
-- Convert a list of edges into a graph.
edgesToGraph :: [(Int, Int)] -> Graph
edgesToGraph es = Graph vs es
  where vs = map fst es ++ map snd es
 
-- Convert a graph into a list of edges.
graphToEdges :: Graph -> [(Int, Int)]
graphToEdges g = concatMap (\(x,y) -> [(x,y),(y,x)]) $ edges g
 
-- Convert a list of edges into a list of pairs.
edgesToList :: [(Int, Int)] -> [(Int, Int)]
edgesToList es = map (\[x,y] -> (x,y)) es
 
-- Convert a list of pairs into a list of edges.
listToEdges :: [(Int, Int)] -> [(Int, Int)]
listToEdges es = map (\(x,y) -> [x,y]) es
 
-- Test the algorithm.
testBFS :: IO ()
testBFS = do
  let g = edgesToGraph $ edgesToList [
      [1,2],[1,3],[1,5],[2,4],[2,5],
      [3,4],[3,6],[4,7],[5,6],[5,7],
      [6,8],[7,8],[8,9]
    ]
  print $ shortestPaths 1 $ vertices g
  print $ shortestPaths 3 $ vertices g
  print $ shortestPaths 5 $ vertices g
  print $ shortestPaths 7 $ vertices g
  print $ shortestPaths 9 $ vertices g
  print $ distance 1 9 $ vertices g
  print $ distance 1 10 $ vertices g
 
-- Main function.
main :: IO ()
main = testBFS
