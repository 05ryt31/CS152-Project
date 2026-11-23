import Data.List.Split (splitOn)
 
data Tree = Empty | Node Int Tree Tree deriving Show
 
-- Insert a value into the tree
insert :: Int -> Tree -> Tree
insert x Empty = Node x Empty Empty
insert x (Node y left right)
  | x == y = Node y left right
  | x < y = Node y (insert x left) right
  | otherwise = Node y left (insert x right)
 
-- Get the height of the tree
height :: Tree -> Int
height Empty = 0
height (Node _ left right) = 1 + max (height left) (height right)
 
-- Perform an in-order traversal of the tree
inOrder :: Tree -> [Int]
inOrder Empty = []
inOrder (Node x left right) = inOrder left ++ [x] ++ inOrder right
 
-- Perform a pre-order traversal of the tree
preOrder :: Tree -> [Int]
preOrder Empty = []
preOrder (Node x left right) = [x] ++ preOrder left ++ preOrder right
 
main :: IO ()
main = do
  putStrLn "Enter numbers separated by spaces:"
  input <- getLine
  let nums = map read $ splitOn " " input
      tree = foldr insert Empty nums
  putStrLn "In order:"
  print $ inOrder tree
  putStrLn "Pre order:"
  print $ preOrder tree
  putStrLn $ "Height: " ++ show (height tree)
