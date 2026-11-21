import Data.List (elemIndex, isPrefixOf, isInfixOf, isSuffixOf, intercalate, lines, words, unwords)
import Data.Maybe (fromJust, fromMaybe)
import System.IO (hFlush, stdout)

-- Read a graph from standard input
readGraph :: Int -> [(Int, Int)]
readGraph m = go 0 []
  where
    go i acc
      | i == m    = acc
      | otherwise = do
          line <- getLine
          let [u, v] = map read $ words line
          go (i + 1) ((u, v) : (v, u) : acc)

-- Get neighbors of a node in the graph
getNeighbors :: Int -> [(Int, Int)] -> [Int]
getNeighbors node graph = [v | (u, v) <- graph, u == node]

-- Expand the current layer of BFS
expandLayer :: [Int] -> [(Int, Int)] -> [Int] -> ([Int], [Int])
expandLayer layer graph visited = (newLayer, newVisited)
  where
    newLayer = concatMap (getNeighbors graph . flip elem layer) [x | x <- [0..], notElem x visited]
    newVisited = visited ++ newLayer

-- Perform BFS to find the shortest path distance
bfs :: Int -> Int -> [(Int, Int)] -> Int
bfs start target graph = go [start] [] 0
  where
    go [] _ _ = -1
    go layer visited dist
      | target `elem` layer = dist
      | otherwise = go nextLayer (newVisited \\ layer) (dist + 1)
      where
        (nextLayer, newVisited) = expandLayer layer graph visited

-- Main function to read input and print the result
main :: IO ()
main = do
  line <- getLine
  let [n, m] = map read $ words line
  graph <- readGraph m
  line <- getLine
  let [s, t] = map read $ words line
  print $ bfs s t graph
