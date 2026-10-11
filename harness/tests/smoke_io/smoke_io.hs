main :: IO ()
main = do
    text <- getLine
    putStrLn $ "Hello, " ++ text
