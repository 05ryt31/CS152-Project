import System.IO
 
bank :: [String] -> Int -> IO ()
bank [] balance = putStrLn $ show balance
bank ("deposit":xs) balance = bank xs (balance + read xs)
bank ("withdraw":xs) balance | balance < read xs = putStrLn "error"
                              | otherwise = bank xs (balance - read xs)
bank ["balance"] balance = putStrLn $ show balance
bank _ _ = putStrLn "error"
 
main = do hSetBuffering stdin NoBuffering; bank =<< lines <$> getContents
