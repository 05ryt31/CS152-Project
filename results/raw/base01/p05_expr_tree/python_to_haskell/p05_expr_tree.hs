module Main where

data Node = Node { token :: String, left :: Maybe Node, right :: Maybe Node } deriving (Show)

build :: [String] -> Node
build tokens = head $ foldl process [] tokens
  where
    process stack token
      | elem token ["+", "-", "*"] = let right = pop stack
                                        left = pop stack
                                    in push stack (Node token (Just left) (Just right))
      | otherwise = push stack (Node token Nothing Nothing)
    pop (x:xs) = (x, xs)
    push xs x = x : xs

render :: Node -> String
render node
  | bothNothing (left node) (right node) = token node
  | otherwise = "(" ++ render (fromJust $ left node) ++ " " ++ token node ++ " " ++ render (fromJust $ right node) ++ ")"
  where
    bothNothing (Just _) _ = False
    bothNothing Nothing (Just _) = False
    bothNothing Nothing Nothing = True
    fromJust (Just x) = x

main :: IO ()
main = do
  tokens <- words <$> getLine
  let tree = build tokens
  putStrLn $ render tree
