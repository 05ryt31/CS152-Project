module Main where

import Data.List (findIndex)
import Data.Maybe (fromJust)

main :: IO ()
main = do
    [n, m] <- map read . words <$> getLine
    let neighbours = replicate (n + 1) []
    edges <- replicateM m $ do
        [u, v] <- map read . words <$> getLine
        return (u, v)
    let graph = foldl addEdge neighbours edges
    [s, t] <- map read . words <$> getLine
    case bfs graph s t of
        Just dist -> print dist
        Nothing   -> print (-1)

addEdge :: [[Int]] -> (Int, Int) -> [[Int]]
addEdge g (u, v) = updateAt u (v:) g ++ updateAt v (u:) g
    where
        updateAt idx f xs = take idx xs ++ [f (xs !! idx)] ++ drop (idx + 1) xs

bfs :: [[Int]] -> Int -> Int -> Maybe Int
bfs graph start end = go [start] (repeat Nothing)
    where
        go [] _ = Nothing
        go (node:rest) distances
            | node == end = Just (fromJust (distances !! node))
            | otherwise   = go newQueue newDistances
            where
                newDistances = updateAt node (Just . (+1)) distances
                unvisitedNeighbours = filter (\n -> isNothing (newDistances !! n)) (graph !! node)
                newQueue = rest ++ unvisitedNeighbours
