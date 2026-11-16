import Data.List (maximumBy, intersperse)
import Data.Maybe (fromJust)
import System.IO (hFlush, stdout)

data Tree = Empty | Node Int Tree Tree deriving (Show)

insert :: Tree -> Int -> Tree
insert Empty v = Node v Empty Empty
insert (Node x left right) v
  | v < x     = Node x (insert left v) right
  | otherwise = Node x left (insert right v)

inorder :: Tree -> [Int]
inorder Empty = []
inorder (Node x left right) = inorder left ++ [x] ++ inorder right

preorder :: Tree -> [Int]
preorder Empty = []
preorder (Node x left right) = [x] ++ preorder left ++ preorder right

height :: Tree -> Int
height Empty = 0
height (Node _ left right) = 1 + max (height left) (height right)

printList :: [Int] -> IO ()
printList [] = return ()
printList xs = do
  putStr $ intercalate " " (map show xs)
  putStrLn ""

numbers :: String -> [Int]
numbers = map read . words

safeReadLine :: IO String
safeReadLine = hGetLine stdin >>= \line -> if null line then return "" else return line

buildTree :: [Int] -> Tree
buildTree = foldl insert Empty

main :: IO ()
main = do
  line <- safeReadLine
  let values = numbers line
      tree = buildTree values
  printList $ inorder tree
  printList $ preorder tree
  print $ height tree
