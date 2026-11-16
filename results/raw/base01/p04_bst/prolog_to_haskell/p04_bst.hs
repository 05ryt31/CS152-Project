import Data.List (maximum)
import Data.Maybe (fromJust)

data BST = Empty | Node Int BST BST deriving (Show)

main :: IO ()
main = do
    line <- getContents
    let ns = nums line
    let tree = foldl insert Empty ns
    let inOrder = inorder tree
    let preOrder = preorder tree
    putStr $ unwords $ show <$> inOrder ++ show <$> preOrder
    putStrLn ""
    print $ height tree

nums :: String -> [Int]
nums "" = []
nums line = case words line of
    [] -> []
    parts -> map read parts

insert :: Int -> BST -> BST
insert x Empty = Node x Empty Empty
insert x (Node y l r)
    | x < y     = Node y (insert x l) r
    | otherwise = Node y l (insert x r)

inorder :: BST -> [Int]
inorder Empty = []
inorder (Node x l r) = inorder l ++ [x] ++ inorder r

preorder :: BST -> [Int]
preorder Empty = []
preorder (Node x l r) = [x] ++ preorder l ++ preorder r

height :: BST -> Int
height Empty = 0
height (Node _ l r) = 1 + maximum [height l, height r]
