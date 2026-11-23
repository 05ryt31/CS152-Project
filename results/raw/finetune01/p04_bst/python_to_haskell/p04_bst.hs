data Tree a = Empty | Node a (Tree a) (Tree a)
 
insert :: Ord a => a -> Tree a -> Tree a
insert x Empty = Node x Empty Empty
insert x (Node y left right)
  | x == y = Node x left right
  | x < y = Node y (insert x left) right
  | otherwise = Node y left (insert x right)
 
inorder :: Tree a -> [a]
inorder Empty = []
inorder (Node x left right) = inorder left ++ [x] ++ inorder right
 
preorder :: Tree a -> [a]
preorder Empty = []
preorder (Node x left right) = [x] ++ preorder left ++ preorder right
 
height :: Tree a -> Int
height Empty = 0
height (Node _ left right) = 1 + max (height left) (height right)
 
main :: IO ()
main = do
  let tree = foldr insert Empty $ map read . words <$> getLine
  putStrLn $ unwords $ show <$> inorder tree
  putStrLn $ unwords $ show <$> preorder tree
  putStrLn $ show $ height tree
