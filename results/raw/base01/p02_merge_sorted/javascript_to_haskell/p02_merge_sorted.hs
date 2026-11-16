import System.IO

parseLine :: String -> [Int]
parseLine line = map read . words $ line

main :: IO ()
main = do
    input <- getContents
    let lines = lines input
        a = parseLine $ head lines
        b = parseLine $ lines !! 1
        result = merge a b
    putStr $ unwords $ map show result ++ ["\n"]

merge :: [Int] -> [Int] -> [Int]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
    | x <= y    = x : merge xs (y:ys)
    | otherwise = y : merge (x:xs) ys
