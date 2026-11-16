module Main where

data Node = Node String Node Node | Leaf String deriving (Show)

render :: Node -> String
render (Leaf token) = token
render (Node token left right) = "(" ++ render left ++ " " ++ token ++ " " ++ render right ++ ")"

main :: IO ()
main = do
    input <- getContents
    let tokens = words input
    let stack = foldl processToken [] tokens
    putStrLn $ render $ head stack

processToken :: [Node] -> String -> [Node]
processToken stack token
    | elem token "+-*" = let right = head stack
                          in processToken (tail (tail stack)) (token ++ " " ++ render right)
    | otherwise = Leaf token : stack
