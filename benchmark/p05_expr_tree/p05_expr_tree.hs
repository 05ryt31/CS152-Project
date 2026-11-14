data Tree = Leaf String | Op String Tree Tree

buildTree :: String -> Tree
buildTree line = head (foldl step [] (words line))

step :: [Tree] -> String -> [Tree]
step (right : left : rest) token | token `elem` "+-*" = Op token left right : rest
step stack token = Leaf token : stack

render :: Tree -> String
render (Leaf x) = x
render (Op op l r) = "(" ++ render l ++ " " ++ op ++ " " ++ render r ++ ")"

main :: IO ()
main = do
    line <- getLine
    putStrLn (render (buildTree (line)))
