import Data.Char (isDigit)
import System.IO

main :: IO ()
main = do
    input <- getContents
    let tokens = tokenize input
    let result = evaluateExpression tokens
    putStr $ show result ++ "\n"

tokenize :: String -> [String]
tokenize = words . map (\c -> if isDigit c then [' '] else c)

evaluateExpression :: [String] -> Int
evaluateExpression tokens = evalExpression tokens 0

evalExpression :: [String] -> Int -> Int
evalExpression [] _ = 0
evalExpression (t:ts) pos
    | t == "(" = evalExpression ts pos
    | t == ")" = pos
    | otherwise = case t of
        "+" -> pos + evalExpression ts 0
        "-" -> pos - evalExpression ts 0
        "*" -> pos * evalExpression ts 0
        _   -> read t
