module Main where

import Data.List (sort)
import System.IO (getContents, putStr)

generate :: [Char] -> [Bool] -> String -> IO ()
generate letters used current
  | length current == length letters = do
      putStrLn current
      return ()
  | otherwise = do
      let unusedIndices = [i | (i, _) <- zip [0..] used, not used !! i]
      mapM_ (\i -> do
          let newUsed = take i used ++ True : drop (i + 1) used
              newCurrent = current ++ [letters !! i]
          generate letters newUsed newCurrent
      ) unusedIndices

main :: IO ()
main = do
  input <- getContents
  let letters = sort $ head $ lines input
  generate letters (replicate (length letters) False) ""
