data Tree a = Empty | Node { left, right :: Tree a, value :: a }
 
-- Insert a new element in the tree
insert x Empty = Node Empty Empty x
insert x t@(Node l r v)
  | x < v     = Node (insert x l) r v
  | otherwise = Node l (insert x r) v
 
-- In-order traversal
inOrder Empty = []
inOrder t = inOrder (left t) ++ [value t] ++ inOrder (right t)
 
-- Pre-order traversal
preOrder Empty = []
preOrder t = [value t] ++ preOrder (left t) ++ preOrder (right t)
 
-- Height of the tree
height Empty = 0
height t = 1 + max (height $ left t) (height $ right t)
 
main = do
  putStrLn "Enter numbers separated by spaces:"
  nums <- getLine
  let tree = foldr insert Empty $ map read $ words nums
  putStrLn "In-order:"
  print $ inOrder tree
  putStrLn "Pre-order:"
  print $ preOrder tree
  putStrLn "Height:"
  print $ height tree
