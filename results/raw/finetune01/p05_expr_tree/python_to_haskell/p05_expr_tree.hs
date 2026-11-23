data ExprTree = Val Int | Plus ExprTree ExprTree | Minus ExprTree ExprTree | Times ExprTree ExprTree deriving Show
 
buildExprTree :: [String] -> ExprTree
buildExprTree [] = error "Empty list"
buildExprTree [x] = Val $ read x
buildExprTree xs =
  let (left,right) = splitAt ((length xs - 1) `div` 2) xs
      op = last xs
  in case op of
       "+" -> Plus (buildExprTree left) (buildExprTree right)
       "-" -> Minus (buildExprTree left) (buildExprTree right)
       "*" -> Times (buildExprTree left) (buildExprTree right)
       _   -> error $ "Unknown operator: " ++ op
 
renderExprTree :: ExprTree -> String
renderExprTree (Val n) = show n
renderExprTree (Plus l r) = "(" ++ renderExprTree l ++ " + " ++ renderExprTree r ++ ")"
renderExprTree (Minus l r) = "(" ++ renderExprTree l ++ " - " ++ renderExprTree r ++ ")"
renderExprTree (Times l r) = "(" ++ renderExprTree l ++ " * " ++ renderExprTree r ++ ")"
 
main = do
  putStrLn $ renderExprTree $ buildExprTree ["3", "*", "(", "2", "+", "5", ")"]
  putStrLn $ renderExprTree $ buildExprTree ["3", "*", "(", "2", "+", "5", ")", "*", "(", "6", "-", "4", ")"]
