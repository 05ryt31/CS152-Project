import Data.Char (isDigit, isSpace)
import Data.List (intercalate)
import System.IO

-- Tokenize the input string
tokenize :: String -> [String]
tokenize = words . filter (/= '\n')

-- Parse the expression
parseExpr :: [String] -> (Int, [String])
parseExpr tokens = parseTerm tokens

parseTerm :: [String] -> (Int, [String])
parseTerm tokens = parseFactor tokens

parseFactor :: [String] -> (Int, [String])
parseFactor tokens = case head tokens of
    n | all isDigit n -> (read n, tail tokens)
    _ -> let (result, rest) = parseExpr (tail tokens) in (result, rest)

-- Calculate the result
calc :: String -> Int
calc = fst . parseExpr . tokenize

main :: IO ()
main = do
    input <- getLine
    print $ calc input
