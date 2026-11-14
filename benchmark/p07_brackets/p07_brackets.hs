import Control.Monad (replicateM)

matching :: Char -> Char -> Bool
matching '(' ')' = True
matching '[' ']' = True
matching '{' '}' = True
matching _ _ = False

balanced :: String -> Bool
balanced text = valid text []
    where 
        valid :: String -> String -> Bool
        valid [] [] = True
        valid (c:cs) stack | c `elem` "([{" = valid cs (c:stack)
                           | null stack = False
                           | matching (head stack) c = valid cs (tail stack)
                           | otherwise = False
        valid _ _ = False

main :: IO ()
main = do
    n <- readLn
    lines <- replicateM n getLine
    mapM_ (putStrLn . (\x -> if balanced x then "yes" else "no")) lines
