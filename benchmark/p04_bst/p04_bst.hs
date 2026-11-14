import System.IO (isEOF)

data Tree = Empty | Node Int (Tree) (Tree)

insert :: Tree -> Int -> Tree
insert Empty x = Node x Empty Empty
insert (Node y l r) x | x < y = Node y (insert l x) r
                      | otherwise = Node y l (insert r x)

inorder :: Tree -> [Int]
inorder Empty = []
inorder (Node x l r) = inorder l ++ [x] ++ inorder r

preorder :: Tree -> [Int]
preorder Empty = []
preorder (Node x l r) = x : preorder l ++ preorder r

height :: Tree -> Int
height Empty = 0
height (Node _ l r) = 1 + max (height l) (height r)

showLine :: [Int] -> String
showLine xs = unwords (map show xs)

safeGetLine :: IO String
safeGetLine = do
    eof <- isEOF
    if eof
        then pure ""
        else getLine

main = do
    values <- fmap (map read . words) safeGetLine
    let tree = foldl insert Empty values
    putStrLn (showLine (inorder tree))
    putStrLn (showLine (preorder tree))
    putStrLn (show (height tree))
