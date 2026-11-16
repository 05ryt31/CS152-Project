import System.IO
import Data.List

main :: IO ()
main = do
    hSetBuffering stdin NoBuffering
    hSetBuffering stdout NoBuffering
    line <- getLine
    parts <- splitString line " "
    values <- mapM readString parts
    kline <- getLine
    k <- readString kline
    result <- stages (read k) values
    output result
    return ()

stages :: Int -> [Int] -> IO [Int]
stages 0 values = return values
stages k values = do
    line <- getLine
    parts <- splitString line " "
    new <- applyStage parts values
    stages (k - 1) new

applyStage :: [String] -> [Int] -> IO [Int]
applyStage ["map", "add", x] values = mapM add (read x) values
applyStage ["map", "mul", x] values = mapM multiply (read x) values
applyStage ["filter", "even"] values = return $ filter even values
applyStage ["filter", "odd"] values = return $ filter odd values
applyStage ["filter", "gt", x] values = mapM greater (read x) values
applyStage ["reduce", "sum"] values = return [sum values]
applyStage ["reduce", "max"] [] = return [none]
applyStage ["reduce", "max"] values = return [maximum values]

add :: Int -> Int -> Int
add n x = x + n

multiply :: Int -> Int -> Int
multiply n x = x * n

greater :: Int -> Int -> Bool
greater n x = x > n

output :: [Int] -> IO ()
output [] = putStrLn ""
output [none] = putStrLn "none"
output values = putStrLn $ intercalate " " (show <$> values)
