import System.IO

main :: IO ()
main = do
    hSetBuffering stdin NoBuffering
    hSetBuffering stdout NoBuffering
    n <- readLn
    let processInput = do
            line <- getLine
            case words line of
                [key, valueStr] -> do
                    let value = read valueStr
                    modifySumAndCount key value
                    processInput
                _ -> return ()
    sums <- newIORef M.empty
    counts <- newIORef M.empty
    processInput
    results <- mapM (\k -> do
        s <- readIORef $ sums ! k
        c <- readIORef $ counts ! k
        return (k, s, c)) . sort . M.keys <$> readIORef sums
    mapM_ (\(k, s, c) -> putStrLn $ k ++ " " ++ show s ++ " " ++ show c) results
    where
        modifySumAndCount key value = do
            s <- readIORef $ sums !? key
            c <- readIORef $ counts !? key
            writeIORef sums $ M.insert key (fromMaybe 0 s + value) sums
            writeIORef counts $ M.insert key (fromMaybe 0 c + 1) counts
