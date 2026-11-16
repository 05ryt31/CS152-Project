module Main where

import Data.List (intercalate)
import System.IO (hGetContents, stdout)

data Node = Node String Node Node | Leaf String deriving (Show)

render :: Node -> String
render (Leaf token) = token
render (Node token left right) = "(" ++ render left ++ " " ++ token ++ " " ++ render right ++ ")"

parseTokens :: [String] -> Node
parseTokens [] = error "Empty input"
parseTokens tokens = head $ foldl parseStack [] tokens
  where
    parseStack :: [Node] -> String -> [Node]
    parseStack stack token
      | elem token "+-*" = let right = head stack; left = stack !! 1 in parseStack (tail (init stack) ++ [Node token left right])
      | otherwise = Leaf token : stack

main :: IO ()
main = do
  input <- hGetContents stdin
  let tokens = words input
  let tree = parseTokens tokens
  putStr $ render tree
