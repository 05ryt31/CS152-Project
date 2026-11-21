{-# LANGUAGE OverloadedStrings #-}

import Data.List (sort)
import Data.Map (Map, empty, insertWith, lookup)
import qualified Data.Map as Map
import Data.Text.IO (readFile, writeFile)
import System.IO (hFlush, stdout)

main :: IO ()
main = do
    input <- getContents
    let lines' = lines input
        n = read $ head lines'
        pairs = map parseLine . tail $ lines'
        grouped = foldl' groupPair empty pairs
        sortedGroups = sort [(key, (sum values, length values)) | (key, values) <- Map.toList grouped]
    putStr $ unlines $ map formatOutput sortedGroups

parseLine :: String -> (String, Int)
parseLine line = (fst pair, snd pair)
  where
    pair = breakOn ' ' line

groupPair :: Map String [Int] -> (String, Int) -> Map String [Int]
groupPair acc (key, value) = insertWith (+) key [value] acc

formatOutput :: (String, (Int, Int)) -> String
formatOutput (key, (sumValues, count)) = key ++ " " ++ show sumValues ++ " " ++ show count
