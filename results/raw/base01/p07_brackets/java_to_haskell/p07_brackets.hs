module Main where

import Data.Char (isDigit)
import Control.Monad (replicateM_)
import Text.Read (readMaybe)

balanced :: String -> Bool
balanced text = case stack of
    [] -> True
    _  -> False
  where
    stack = foldl process [] text
    process s c
      | c == '(' || c == '[' || c == '{' = c:s
      | otherwise = case s of
          [] -> []
          t@(x:xs)
              | c == ')' && x == '(' = xs
              | c == ']' && x == '[' = xs
              | c == '}' && x == '{' = xs
              | otherwise = s

main :: IO ()
main = do
    n <- readMaybe . head <$> lines <$> getContents
    replicateM_ n $ do
        line <- getLine
        putStrLn $ if balanced line then "yes" else "no"
