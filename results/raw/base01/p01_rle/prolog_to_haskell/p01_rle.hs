import System.IO

main :: IO ()
main = do
    hSetBuffering stdin NoBuffering
    hSetBuffering stdout NoBuffering
    line <- getContents
    let chars = filter (/= '\n') line
    out <- encode chars
    putStr out
    return ()

encode :: String -> IO String
encode [] = pure []
encode (c:cs) = do
    rest <- encode cs
    count <- run c cs 1
    let encoded = show count ++ [c]
    pure $ encoded ++ rest

run :: Char -> String -> Int -> IO Int
run _ [] n = pure n
run c (x:xs) n | c == x = run c xs (n + 1)
               | otherwise = pure n
