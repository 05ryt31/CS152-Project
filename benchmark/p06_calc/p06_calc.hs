tokens :: String -> [String]
tokens [] = []
tokens (c:cs) | c == ' ' = tokens cs
              | c `elem` "+-*()" = [c] : tokens cs
              | otherwise = let (digits, rest) = span (`elem` ['0'..'9']) (c:cs) in digits : tokens rest

parseExpression :: [String] -> (Int, [String])
parseExpression p = 
    let (x, rest) = parseTerm p 
    in parseAdds x rest
    where 
        parseAdds :: Int -> [String] -> (Int, [String])
        parseAdds x (op:rest) 
            | op == "+" || op == "-" = let (y, rest') = parseTerm rest in parseAdds (if op == "+" then x+y else x-y) rest'
        parseAdds x rest = (x, rest)

parseTerm :: [String] -> (Int, [String])
parseTerm p = 
    let (x, rest) = parseFactor p 
    in parseMuls x rest
    where 
        parseMuls :: Int -> [String] -> (Int, [String])
        parseMuls x ("*":rest) = let (y, rest') = parseFactor rest in parseMuls (x*y) rest'
        parseMuls x rest = (x, rest)

parseFactor :: [String] -> (Int, [String])
parseFactor ("(":rest) = let (x, ")":rest') = parseExpression rest in (x, rest')
parseFactor (x:rest) = (read x, rest)

main :: IO ()
main = do
    line <- getLine
    putStrLn (show (fst (parseExpression (tokens line))))
