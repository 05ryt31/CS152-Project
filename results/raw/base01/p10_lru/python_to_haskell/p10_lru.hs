import System.IO
import Data.Map (Map, empty, insert, lookup, delete)
import qualified Data.Map as Map
import Data.List (elemIndex)

main :: IO ()
main = do
    hSetBuffering stdin NoBuffering
    hSetBuffering stdout NoBuffering
    capacity <- readLn
    n <- readLn
    let (values, order) = processInput capacity n []
    putStr $ unlines $ map show order

processInput :: Int -> Int -> [(Int, Int)] -> ([Int], [Int])
processInput _ 0 _ = ([], [])
processInput capacity n xs = case lines <$> getContents of
    Just inputLines ->
        foldl' processLine (xs, []) inputLines
    Nothing -> ([], [])

processLine :: ([(Int, Int)], [Int]) -> String -> ([(Int, Int)], [Int])
processLine (values, order) line =
    case words line of
        ["get", k] ->
            case lookup (read k) values of
                Just v -> ((values, insert (read k) v order))
                Nothing -> ((values, order ++ [read k]))
        ["set", k, v] ->
            let newOrder = case elemIndex (read k) order of
                    Just idx -> take idx order ++ drop (idx + 1) order ++ [read k]
                    Nothing -> order ++ [read k]
            in ((insert (read k) (read v) values, newOrder))
        _ -> ((values, order))
