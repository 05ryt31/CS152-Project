import System.IO
import Data.List

main :: IO ()
main = do
    input <- getContents
    let lines = lines input
        first = (head lines <|> "") >>= trim
        values = case first of
            "" -> []
            _  -> map read . words $ first
        k = read $ lines !! 1
        operations = take k $ drop 2 lines
        result = foldl applyOperation values operations
        output = case result of
            [] -> "none"
            xs -> unwords $ map show xs
    putStr output

applyOperation :: [Int] -> String -> [Int]
applyOperation xs op = case words op of
    ["map", "add", n] -> map (+ read n) xs
    ["map", "mul", n] -> map (* read n) xs
    ["filter", "even"] -> filter even xs
    ["filter", "odd"] -> filter odd xs
    ["filter", "gt", n] -> filter (> read n) xs
    ["reduce", "sum"] -> [sum xs]
    _ -> xs

trim :: String -> String
trim = dropWhileEnd isSpace . dropWhile isSpace
