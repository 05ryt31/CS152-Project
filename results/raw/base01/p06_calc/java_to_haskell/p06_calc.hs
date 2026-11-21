module Main where

import Data.Char (isDigit, isSpace)
import Text.Read (reads)

data Parser = Parser { tokens :: [String], pos :: Int }

parse :: String -> Parser
parse text = Parser { tokens = tokenize text, pos = 0 }

tokenize :: String -> [String]
tokenize = filter (/= "") . words . concatMap (\c -> if isSpace c then " " else [c])

peek :: Parser -> Maybe String
peek p = if pos p < length (tokens p) then Just (tokens p !! pos p) else Nothing

next :: Parser -> String
next p = let t = tokens p !! pos p in Parser { tokens = tokens p, pos = pos p + 1 } t

expression :: Parser -> Int
expression p = let value = term p in case peek p of
    Just "+" -> expression (next p) + term p
    Just "-" -> expression (next p) - term p
    _ -> value

term :: Parser -> Int
term p = let value = factor p in case peek p of
    Just "*" -> term (next p) * factor p
    _ -> value

factor :: Parser -> Int
factor p = case peek p of
    Just "(" -> let value = expression (next p) in next p; value
    _ -> read $ next p

main :: IO ()
main = do
    text <- getLine
    print $ expression $ parse text
