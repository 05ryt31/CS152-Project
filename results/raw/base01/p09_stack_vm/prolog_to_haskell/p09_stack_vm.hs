import System.IO
import Data.List

main :: IO ()
main = do
    n <- readLn
    stackVM n []

stackVM :: Int -> [Int] -> IO ()
stackVM 0 stack = return ()
stackVM n stack = do
    line <- getLine
    let parts = words line
    newStack <- execute parts stack
    stackVM (n - 1) newStack

execute :: [String] -> [Int] -> IO [Int]
execute ["push", x] stack = return $ read x : stack
execute ["pop"] [] = do
    putStrLn "error"
    return []
execute ["pop"] (_:_) = return []
execute [op] stack | op `elem` ["add", "mul"] && length stack < 2 = do
    putStrLn "error"
    return stack
execute ["add"] (b:a:s) = return $ c:s where c = a + b
execute ["mul"] (b:a:s) = return $ c:s where c = a * b
execute ["dup"] [] = do
    putStrLn "error"
    return []
execute ["dup"] (x:xs) = return $ x:x:xs
execute ["swap"] (a:b:s) = return $ b:a:s
execute ["swap"] s | length s < 2 = do
    putStrLn "error"
    return s
execute ["print"] [] = do
    putStrLn "error"
    return []
execute ["print"] (x:_) = do
    print x
    return (x:)
