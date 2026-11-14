import Control.Monad (replicateM)
import Data.List (mapAccumL)
import Data.Maybe (catMaybes)
import Text.Read (readMaybe)

step :: [Int] -> String -> ([Int], Maybe String)
step stack "pop"
    | null stack = (stack, Just "error")
    | otherwise = (tail stack, Nothing)
step stack "add" 
    | length stack < 2 = (stack, Just "error")
    | otherwise = (head stack + head (tail stack) : tail (tail stack), Nothing)
step stack "mul" 
    | length stack < 2 = (stack, Just "error")
    | otherwise = (head stack * head (tail stack) : tail (tail stack), Nothing)
step stack "dup" 
    | null stack = (stack, Just "error")
    | otherwise = (head stack : stack, Nothing)
step stack "swap" 
    | length stack < 2 = (stack, Just "error")
    | otherwise = (head (tail stack) : head stack : tail (tail stack), Nothing)
step stack "print" 
    | null stack = (stack, Just "error")
    | otherwise = (stack, Just (show (head stack)))
step stack _ = (stack, Nothing)

runStack :: [String] -> [String]
runStack commands = catMaybes rawOutputs
    where
        (_, rawOutputs) = mapAccumL apply [] commands

        apply :: [Int] -> String -> ([Int], Maybe String)
        apply stack command = case words command of
            ["push", x] | Just val <- readMaybe x ->
                (val : stack, Nothing)
            [op] ->
                step stack op
            _ ->
                (stack, Nothing)

main = do
    n <- readLn
    commands <- replicateM n getLine
    putStr (unlines (runStack commands))
