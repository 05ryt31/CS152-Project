module Main where

data Node = Node Int Node Node deriving (Show)

insert :: Node -> Int -> Node
insert (Node v l r) x
  | x < v     = Node v (insert l x) r
  | otherwise = Node v l (insert r x)
insert Null x = Node x Null Null

inorder :: Node -> [Int]
inorder Null = []
inorder (Node v l r) = inorder l ++ [v] ++ inorder r

preorder :: Node -> [Int]
preorder Null = []
preorder (Node v l r) = [v] ++ preorder l ++ preorder r

height :: Node -> Int
height Null = 0
height (Node _ l r) = 1 + max (height l) (height r)

main :: IO ()
main = do
  line <- getLine
  let tokens = words line
      root = foldl (\acc x -> insert acc (read x)) Null tokens
      inOrder = inorder root
      preOrder = preorder root
      h = height root
  putStr $ unwords (map show inOrder) ++ "\n"
  putStr $ unwords (map show preOrder) ++ "\n"
  print h
