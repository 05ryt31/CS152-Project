import Data.List (splitOn)
import System.IO

data Expr = Leaf String | Op Char Expr Expr deriving (Show)

main :: IO ()
main = do
    line <- getLine
    let tokens = splitOn " " line
    tree <- buildExpr tokens []
    text <- renderExpr tree
    putStrLn text

buildExpr :: [String] -> [Expr] -> IO Expr
buildExpr [] stack = return $ head stack
buildExpr (token:tokens) stack
    | elem token "+-*" = do
        right <- buildExpr tokens stack
        left <- buildExpr tokens [right]
        return $ Op (head token) left right
    | otherwise = return $ Leaf token

renderExpr :: Expr -> IO String
renderExpr (Leaf text) = return text
renderExpr (Op op left right) = do
    l <- renderExpr left
    r <- renderExpr right
    return $ "(" ++ l ++ " " ++ [op] ++ " " ++ r ++ ")"
