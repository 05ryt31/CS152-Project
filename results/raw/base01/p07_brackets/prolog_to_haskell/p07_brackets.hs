import System.IO

main :: IO ()
main = do
    nLine <- getLine
    let n = read nLine :: Int
    run n
    return ()

run :: Int -> IO ()
run 0 = return ()
run n | n > 0     = do
    line <- getLine
    if balanced line then putStrLn "yes" else putStrLn "no"
    run $ n - 1

balanced :: String -> Bool
balanced line = balancedChars (stringToCharArray line) []

balancedChars :: [Char] -> [Char] -> Bool
balancedChars [] _ = True
balancedChars (c:cs) stack
    | c `elem` "([{" = balancedChars cs (c:stack)
    | otherwise       = case stack of
                            []      -> False
                            (o:os)  -> matching o c && balancedChars cs os

matching :: Char -> Char -> Bool
matching '(' ')' = True
matching '[' ']' = True
matching '{' '}' = True
matching _ _     = False

stringToCharArray :: String -> [Char]
stringToCharArray = id
