import Control.Monad (replicateM)
import Data.List (mapAccumL)
import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import Data.Maybe (catMaybes)
import Text.Read (readMaybe)

touch :: Int -> [Int] -> [Int]
touch key order = filter (/= key) order ++ [key]

runLRU :: Int -> [String] -> [String]
runLRU cap commands = catMaybes rawOutputs
    where
        (_, rawOutputs) = mapAccumL apply (Map.empty, []) commands

        apply :: (Map Int Int, [Int]) -> String -> ((Map Int Int, [Int]), Maybe String)
        apply state@(values, order) line = case words line of
            ["get", k] | Just key <- readMaybe k ->
                case Map.lookup key values of
                    Nothing    -> ((values, order), Just "-1")
                    Just value -> ((values, touch key order), Just (show value))

            ["put", k, v] | Just key <- readMaybe k, Just val <- readMaybe v ->
                let updated  = Map.insert key val values
                    newOrder = touch key order
                    (finalValues, bounded) = case newOrder of
                        (oldest : rest) | not (Map.member key values) && length newOrder > cap ->
                            (Map.delete oldest updated, rest)
                        _ ->
                            (updated, newOrder)
                in ((finalValues, bounded), Nothing)

            _ -> (state, Nothing)

main = do
    cap <- readLn
    n <- readLn
    commands <- replicateM n getLine
    putStr (unlines (runLRU cap commands))
