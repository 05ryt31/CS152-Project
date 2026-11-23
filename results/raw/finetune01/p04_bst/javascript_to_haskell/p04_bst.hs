data Tree a = Empty | Node a (Tree a) (Tree a)
 
insert x Empty = Node x Empty Empty
insert x (Node y l r)
  | x == y = Node x l r
  | x < y = Node y (insert x l) r
  | otherwise = Node y l (insert x r)
 
inorder Empty = []
inorder (Node x l r) = inorder l ++ [x] ++ inorder r
 
preorder Empty = []
preorder (Node x l r) = [x] ++ preorder l ++ preorder r
 
height Empty = 0
height (Node _ l r) = 1 + max (height l) (height r)
 
main = do
  putStrLn "Enter numbers separated by spaces:"
  nums <- getLine
  let tree = foldr insert Empty $ map read $ words nums
  putStrLn "In-order traversal:"
  print $ inorder tree
  putStrLn "Pre-order traversal:"
  print $ preorder tree
  putStrLn "Height:"
  print $ height tree
