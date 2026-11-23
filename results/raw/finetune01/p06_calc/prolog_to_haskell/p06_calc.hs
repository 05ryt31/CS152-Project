import Text.ParserCombinators.Parsec
 
-- Parser for arithmetic expressions
expr = term `chainl1` addop
term   = factor `chainl1` mulop
factor = parens expr <|> number
number = read <$> many1 digit
addop  = spaces *> ((,) <$ char '+' <*> return (+)) <* spaces <|>
         spaces *> ((,) <$ char '-' <*> return (-)) <* spaces
mulop  = spaces *> ((,) <$ char '*' <*> return (*)) <* spaces <|>
         spaces *> ((,) <$ char '/' <*> return div) <* spaces
parens = between (char '(') (char ')')
 
-- Evaluate parsed expression
evalExpr = foldl (\a (f,b) -> f a b)
 
-- Main function
main = do
  putStrLn "Enter an arithmetic expression:"
  s <- getLine
  case parse expr "" s of
    Left e  -> putStrLn $ "Error parsing expression: " ++ show e
    Right x -> print $ evalExpr x
