module Main where

data Node = Node {
    value :: Int,
    left  :: Maybe Node,
    right :: Maybe Node
} deriving (Show)

insert :: Maybe Node -> Int -> Maybe Node
insert Nothing v = Just $ Node v Nothing Nothing
insert (Just node) v
    | v < value node = Just $ node { left = insert (left node) v }
    | otherwise      = Just $ node { right = insert (right node) v }

inorder :: Maybe Node -> [Int]
inorder Nothing = []
inorder (Just node) = inorder (left node) ++ [value node] ++ inorder (right node)

preorder :: Maybe Node -> [Int]
preorder Nothing = []
preorder (Just node) = [value node] ++ preorder (left node) ++ preorder (right node)

height :: Maybe Node -> Int
height Nothing = 0
height (Just node) = 1 + max (height (left node)) (height (right node))

main :: IO ()
main = do
    input <- getContents
    let tokens = words input
        root = foldl (\acc token -> insert acc (read token)) Nothing tokens
        inValues = inorder root
        preValues = preorder root
    putStr $ unwords (map show inValues) ++ "\n"
    putStr $ unwords (map show preValues) ++ "\n"
    print $ height root
