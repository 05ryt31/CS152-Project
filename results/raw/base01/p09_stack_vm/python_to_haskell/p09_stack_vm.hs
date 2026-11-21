import System.IO

main :: IO ()
main = do
    hSetBuffering stdin NoBuffering
    hSetBuffering stdout NoBuffering
    n <- readLn
    stack <- processCommands n
    mapM_ print stack

processCommands :: Int -> IO [Int]
processCommands n = go [] <$> replicateM n getCommand
  where
    go :: [Int] -> [Command] -> IO [Int]
    go acc [] = return acc
    go acc cmds = case cmds of
        Push x : rest -> go (x : acc) rest
        Pop : rest ->
            if null acc then putStrLn "error" >> go acc rest
            else go (tail acc) rest
        Add : rest ->
            if length acc < 2 then putStrLn "error" >> go acc rest
            else let (b:a:rest') = acc in go (a + b : rest') rest
        Mul : rest ->
            if length acc < 2 then putStrLn "error" >> go acc rest
            else let (b:a:rest') = acc in go (a * b : rest') rest
        Dup : rest ->
            if null acc then putStrLn "error" >> go acc rest
            else go (acc ++ [last acc]) rest
        Swap : rest ->
            if length acc < 2 then putStrLn "error" >> go acc rest
            else let (b:a:rest') = acc in go (a : b : rest') rest
        Print : rest ->
            if null acc then putStrLn "error"
            else do
                print $ last acc
                go (init acc) rest

data Command = Push Int | Pop | Add | Mul | Dup | Swap | Print deriving (Show)

getCommand :: IO Command
getCommand = do
    line <- getLine
    let parts = words line
    case parts of
        ["push", x] -> return $ Push (read x)
        ["pop"] -> return Pop
        ["add"] -> return Add
        ["mul"] -> return Mul
        ["dup"] -> return Dup
        ["swap"] -> return Swap
        ["print"] -> return Print
        _ -> error "Invalid command"
