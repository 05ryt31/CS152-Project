import Data.List (find, isInfixOf)
import Data.Maybe (fromJust)

main :: IO ()
main = do
    firstLine <- getLine
    let [ns, ms] = map read . words $ firstLine
    graph <- buildGraph ms []
    lastLine <- getLine
    let [ss, ts] = map read . words $ lastLine
    let result = bfs [(ss, 0)] [ss] graph ts
    print result

buildGraph :: Int -> [[Int]] -> IO [[Int]]
buildGraph 0 graph = return graph
buildGraph n graph = do
    line <- getLine
    let [u, v] = map read . words $ line
    let newGraph = addEdge u v graph
    buildGraph (n - 1) newGraph

addEdge :: Int -> Int -> [[Int]] -> [[Int]]
addEdge u v graph = updateAdj u v graph ++ updateAdj v u graph

updateAdj :: Int -> Int -> [[Int]] -> [[Int]]
updateAdj _ _ [] = []
updateAdj u v (x@(y:_):xs)
    | y == u = x { snd = v : snd x } : xs
    | otherwise = x : updateAdj u v xs

bfs :: [(Int, Int)] -> [Int] -> [[Int]] -> Int -> Int
bfs [] _ _ _ = -1
bfs ((node, distance):queue) seen graph target
    | node == target = distance
    | otherwise = bfs (queue ++ newQueue) (node : seen) graph target
    where
        neighbors = findNeighbors node graph
        unseenNeighbors = filter (\n -> notElem n seen) neighbors
        newQueue = [(n, distance + 1) | n <- unseenNeighbors]

findNeighbors :: Int -> [[Int]] -> [Int]
findNeighbors node graph = concatMap snd $ filter (\(x, _) -> x == node) graph
