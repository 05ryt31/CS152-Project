import Text.ParserCombinators.Parsec
 
-- Parser for arithmetic expressions
expr :: Parser Int
expr = do
  e <- term
  restOfExpr e
 
restOfExpr :: Int -> Parser Int
restOfExpr acc =
  try ((+) <$> char '+' <*> expr)
  <|> try ((-) <$> char '-' <*> expr)
  <|> return acc
 
term :: Parser Int
term = do
  t <- factor
  restOfTerm t
 
restOfTerm :: Int -> Parser Int
restOfTerm acc =
  try ((*acc) <$> char '*' <*> term)
  <|> return acc
 
factor :: Parser Int
factor = do
  f <- number
  restOfFactor f
 
restOfFactor :: Int -> Parser Int
restOfFactor acc =
  try ((^acc) <$> char '^' <*> factor)
  <|> return acc
 
number :: Parser Int
number = read <$> many1 digit
 
-- Parsing function
parseExpr :: String -> Either ParseError Int
parseExpr s = parse expr "" s
 
-- Main function
main :: IO ()
main = do
  print $ parseExpr "3"
  print $ parseExpr "2 * 3 + (4 * 5)"
  print $ parseExpr "7 ^ 2"
  print $ parseExpr "2 + 3 * 4 ^ 5 ^ 2"
