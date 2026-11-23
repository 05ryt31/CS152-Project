data Expr = Val Int | Add Expr Expr | Mul Expr Expr deriving Show
 
parse :: [Char] -> Expr
parse = parse' . words
  where
    parse' [] = error "Empty expression"
    parse' [x] = Val $ read x
    parse' xs =
      let (ys, zs) = splitAt n xs
          e1 = parse' ys
          e2 = parse' zs
      in case last ys of
           '+' -> Add e1 e2
           '*' -> Mul e1 e2
           _   -> error "Invalid operator"
      where
        n = length $ takeWhile (/= ')') $ dropWhile (/= '(') xs
 
eval :: Expr -> Int
eval (Val x) = x
eval (Add e1 e2) = eval e1 + eval e2
eval (Mul e1 e2) = eval e1 * eval e2
 
showExpr :: Expr -> String
showExpr (Val x) = show x
showExpr (Add e1 e2) = showExpr e1 ++ " + " ++ showExpr e2
showExpr (Mul e1 e2) = showExpr e1 ++ " * " ++ showExpr e2
 
main :: IO ()
main = do
  putStrLn "Enter an arithmetic expression:"
  expr <- getLine
  putStrLn $ "Parsed: " ++ show (parse expr)
  putStrLn $ "Evaluated: " ++ show (eval $ parse expr)
  putStrLn $ "Formatted: " ++ showExpr (parse expr)
