import Data.List.Split (splitOn)
 
data Expr = Val Int | Add Expr Expr | Mul Expr Expr deriving Show
 
parseExpr :: String -> Expr
parseExpr s = parse $ splitOn " " s
  where
    parse [x] = Val $ read x
    parse (x:xs) =
      case x of
        "+" -> Add (parse xs1) (parse xs2)
        "*" -> Mul (parse xs1) (parse xs2)
        _   -> error "Invalid expression"
      where
        (xs1, _:xs2) = break (== x) xs
 
eval :: Expr -> Int
eval (Val n) = n
eval (Add e1 e2) = eval e1 + eval e2
eval (Mul e1 e2) = eval e1 * eval e2
 
main :: IO ()
main = do
  putStrLn $ show $ parseExpr "3 + 2 * 8" -- Val 19
  putStrLn $ show $ parseExpr "3 + (2 * 8)" -- Add (Val 3) (Mul (Val 2) (Val 8))
  putStrLn $ show $ eval $ parseExpr "3 + 2 * 8" -- 19
  putStrLn $ show $ eval $ parseExpr "3 + (2 * 8)" -- 19
