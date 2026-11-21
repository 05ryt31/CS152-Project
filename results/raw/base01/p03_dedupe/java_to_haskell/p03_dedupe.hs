module Main where

import Data.Set (Set)
import qualified Data.Set as Set
import Control.Monad (when)

main :: IO ()
main = do
    line <- getLine
    let tokens = words line
    let uniqueTokens = filterUnique tokens
    putStr $ unwords uniqueTokens ++ "\n"

filterUnique :: [String] -> [String]
filterUnique [] = []
filterUnique (x:xs) = x : filterUnique (filter (/= x) xs)
