data Tree a = Empty | Node a (Tree a) (Tree a)
 
insert :: Ord a => a -> Tree a -> Tree a
insert x Empty = Node x Empty Empty
insert x (Node y l r)
  | x == y = Node x l r
  | x < y = Node y (insert x l) r
  | otherwise = Node y l (insert x r)
 
inorder, preorder :: Tree a -> [a]
inorder Empty = []
inorder (Node x l r) = inorder l ++ [x] ++ inorder r
preorder Empty = []
preorder (Node x l r) = [x] ++ preorder l ++ preorder r
 
height :: Tree a -> Int
height Empty = 0
height (Node _ l r) = 1 + max (height l) (height r)
 
main :: IO ()
main = do
  putStrLn "Enter numbers:"
  nums <- map read . words <$> getLine
  let tree = foldr insert Empty nums
  putStrLn $ "In-order: " ++ show (inorder tree)
  putStrLn $ "Pre-order: " ++ show (preorder tree)
  putStrLn $ "Height: " ++ show (height tree)
