module Main where

import Data.List (find)
import Data.Maybe (fromJust)

main :: IO ()
main = do
    input <- getContents
    let [n:m:_] = map read . words $ head (lines input)
    let edges = tail (lines input)
    let graph = buildGraph n edges
    let [start:target:_] = map read . words $ last (lines input)
    print $ bfsDistance graph start target

buildGraph :: Int -> [String] -> [[Int]]
buildGraph n edges = foldl addEdge (replicate (n + 1) []) edges
  where
    addEdge g (e:_) = let [u:v:_] = map read . words $ e in
                      g { !! u = v : g !! u,
                          !! v = u : g !! v }

bfsDistance :: [[Int]] -> Int -> Int -> Maybe Int
bfsDistance graph start target = go [start] (-1)
  where
    go [] _ = Nothing
    go (node:rest) dist =
      case find ((== target) . snd) (zip rest (repeat (dist + 1))) of
        Just _ -> Just (dist + 1)
        Nothing ->
          let nextNodes = concatMap (\v -> filter (/= node) (graph !! v)) rest
              newDist = dist + 1
          in go (nextNodes ++ rest) newDist
