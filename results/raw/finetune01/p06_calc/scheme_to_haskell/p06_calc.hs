import Text.ParserCombinators.Parsec
 
-- Parser for arithmetic expressions
arithParser = parse arith "" . unwords
 
-- Arithmetic expression parser
arith :: Parser Int
arith = foldl1 (+) <$> many term
 
-- Term parser
term :: Parser Int
term = foldl1 (*) <$> many factor
 
-- Factor parser
factor :: Parser Int
factor = number <|> parens
 
-- Number parser
number :: Parser Int
number = read <$> many1 digit
 
-- Parentheses parser
parens :: Parser Int
parens = between (char '(') (char ')') arith
 
-- Test cases
testCases :: [String]
testCases =
  [ "3 + 2 * 5"
  , "3 + 2 * 5 - 1"
  , "3 + 2 * (5 - 1)"
  , "3 + 2 * (5 - 1) ^ 2 ^ 3"
  ]
 
-- Main function
main :: IO ()
main = mapM_ print $ arithParser <$> testCases
