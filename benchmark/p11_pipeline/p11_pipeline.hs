import Control.Monad (replicateM)

apply :: [Int] -> [String] -> [Int]
apply xs ["map", "add", n] = map (+ read n) xs
apply xs ["map", "mul", n] = map (* read n) xs
apply xs ["filter", "even"] = filter even xs
apply xs ["filter", "odd"] = filter odd xs
apply xs ["filter", "gt", n] = filter (> read n) xs
apply xs ["reduce", "sum"] = [sum xs]
apply [] ["reduce", "max"] = []
apply xs ["reduce", "max"] = [maximum xs]

readNums :: String -> [Int]
readNums s = map read (words s)

main :: IO ()
main = do
    values <- getLine
    k <- readLn
    stages <- replicateM k getLine
    let result = foldl (\xs stage -> apply xs (words stage)) (readNums values) stages
    case result of
        [] | k > 0 && "reduce" `elem` words (last stages) -> putStrLn "none"
        [] -> return ()
        xs -> putStrLn (unwords (map show xs))
