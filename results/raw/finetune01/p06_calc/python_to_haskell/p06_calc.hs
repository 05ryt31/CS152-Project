import Text.ParserCombinators.Parsec
 
-- Parser for arithmetic expressions
expr :: Parser Int
expr = foldl1 (+) <$> many1 term
 
term :: Parser Int
term = foldl1 (*) <$> many1 factor
 
factor :: Parser Int
factor =
  negate <$ char '-' <*> expr
  <|> pure <$> expr
  <|> parens expr
  <|> read <$> many1 digit
 
parens :: Parser a -> Parser a
parens p = char '(' *> p <* char ')'
 
-- Evaluate an arithmetic expression
eval :: String -> Int
eval = fst . head . parse expr ""
 
-- Test cases
main :: IO ()
main = do
  mapM_ (\s -> putStrLn $ show s ++ " = " ++ show (eval s)) $
    [ "3"
    , "2+2"
    , "2*2"
    , "2*(2+2)"
    , "(2+2)*2"
    , "2+(2*2)"
    , "2+2*2"
    , "2*(2+2)*2"
    , "2+2*2+2"
    , "2*(2+2)*2+2"
    ]
