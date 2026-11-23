import Data.List.Split (splitOn)
 
data Expr = Val Int | Add Expr Expr | Mul Expr Expr deriving Show
 
parseExpr :: String -> Expr
parseExpr s = parse $ splitOn " " s
  where
    parse [] = Val 0
    parse [x] = Val $ read x
    parse (x:xs)
      | elem x ["+", "*"] = case x of
          "+" -> Add (parse l) (parse r)
          "*" -> Mul (parse l) (parse r)
      where
        (l, r) = splitAt ((length xs) `div` 2) xs
 
eval :: Expr -> Int
eval (Val n) = n
eval (Add e1 e2) = eval e1 + eval e2
eval (Mul e1 e2) = eval e1 * eval e2
 
main :: IO ()
main = do
  putStrLn "Enter expression:"
  expr <- getLine
  let parsed = parseExpr expr
  putStrLn $ "Parsed: " ++ show parsed
  putStrLn $ "Evaluated: " ++ show (eval parsed)
