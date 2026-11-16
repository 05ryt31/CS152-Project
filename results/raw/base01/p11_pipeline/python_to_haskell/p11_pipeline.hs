import System.IO

applyStage :: [Int] -> [String] -> [Int] -> [Int]
applyStage values parts =
    case head parts of
        "map" ->
            let amount = read $ parts !! 2
                op = if parts !! 1 == "add" then (+) else (*)
            in map op values
        "filter" ->
            let pred = case parts !! 1 of
                            "even" -> even
                            "odd" -> odd
                            "gt" -> (> read $ parts !! 2)
            in filter pred values
        _ -> values

reduce :: [Int] -> Int
reduce [] = error "empty list"
reduce xs = maximum xs

main :: IO ()
main = do
    hSetBuffering stdin NoBuffering
    hSetBuffering stdout NoBuffering
    values <- map read . words <$> getLine
    k <- read <$> getLine
    let finalValues = foldl applyStage values (replicate k (words <$> getLine))
    if null finalValues
        then putStrLn "none"
        else putStr $ unwords (map show finalValues)
