import Data.List (splitOn, isPrefixOf)
import System.IO

data Expr = Lit String | BinOp String Expr Expr deriving (Show)

build :: [String] -> Expr
build tokens = head $ foldl parse [] tokens
  where
    parse acc ("+" : xs) = parse (BinOp "+" (head acc) (build xs)) (tail xs)
    parse acc ("-") = parse (BinOp "-" (head acc) (build (tail xs))) (tail xs)
    parse acc ("*" : xs) = parse (BinOp "*" (head acc) (build xs)) (tail xs)
    parse acc (x : xs) = parse ((Lit x) : acc) xs

render :: Expr -> String
render (Lit s) = s
render (BinOp op l r) = "(" ++ render l ++ " " ++ op ++ " " ++ render r ++ ")"

main :: IO ()
main = do
  input <- getLine
  let expr = build $ splitOn " " input
  putStrLn $ render expr
