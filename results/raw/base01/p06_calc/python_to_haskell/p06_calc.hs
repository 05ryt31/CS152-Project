module Main where

import Data.Char (isDigit, isSpace)
import System.IO (hGetContents, stdout)

data Token = Number Int | Operator Char deriving (Show)

tokenize :: String -> [Token]
tokenize = filter (/= "") . concatMap tokenizeChar
  where
    tokenizeChar c
      | isDigit c = [Number (read [c])]
      | isSpace c = [[]]
      | otherwise = [[Operator c]]

parseExpression :: [Token] -> Int
parseExpression = parseTerm . dropWhile (\(Operator _) -> True)

parseTerm :: [Token] -> Int
parseTerm = foldl parseFactor 1

parseFactor :: Int -> [Token] -> Int
parseFactor acc [] = acc
parseFactor acc ((Number n):xs) = parseFactor (acc * n) xs
parseFactor acc ((Operator '+'):xs) = parseExpression xs + acc
parseFactor acc ((Operator '-'):xs) = parseExpression xs - acc
parseFactor _ _ = error "Invalid token"

main :: IO ()
main = do
  input <- hGetContents stdin
  let tokens = tokenize input
  let result = parseExpression tokens
  putStrLn $ show result
