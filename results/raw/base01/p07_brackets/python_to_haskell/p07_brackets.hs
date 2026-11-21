{-# LANGUAGE OverloadedStrings #-}

import Control.Monad (forM_)
import Data.Char (isDigit)
import Data.List (findIndex)
import System.IO (hGetContents, stdin)

pairs :: [(Char, Char)]
pairs = [')' `assoc` '(', ']' `assoc` '[', '}' `assoc` '{']
  where
    assoc x y = (x, y)

balanced :: String -> Bool
balanced s = go [] s == []
  where
    go :: [Char] -> String -> [Char]
    go acc [] = acc
    go acc (c:cs)
      | c `elem` "([{" = go (c : acc) cs
      | otherwise       = case findIndex (== c) pairs of
                            Just i  -> case acc of
                                          []     -> []
                                          (d:ds) -> if d == snd $ pairs !! i then go ds cs else []
                            Nothing -> []

main :: IO ()
main = do
  contents <- hGetContents stdin
  let lines' = lines contents
  forM_ (tail lines') $ \line ->
    putStrLn $ if balanced line then "yes" else "no"
