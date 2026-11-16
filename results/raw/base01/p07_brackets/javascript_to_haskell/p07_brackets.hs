{-# LANGUAGE OverloadedStrings #-}

import Data.Char (isDigit)
import Data.List (findIndex)
import System.IO

pairs :: [(Char, Char)]
pairs = [(')', '('), (']', '['), ('}', '{')]

balanced :: String -> Bool
balanced text = go [] text
  where
    go :: [Char] -> String -> Bool
    go stack [] = null stack
    go stack (x:xs)
      | x `elem` "([{" = go (x:stack) xs
      | otherwise       = case findIndex (== x) (map snd pairs) of
                            Just idx -> case stack of
                                          []     -> False
                                          y:ys   -> y == fst (pairs !! idx) && go ys xs
                            Nothing  -> False

main :: IO ()
main = do
  input <- getContents
  let lines = lines input
      n = read . head $ lines
      results = map (\line -> if balanced line then "yes" else "no") (tail lines)
  putStr $ unlines results
