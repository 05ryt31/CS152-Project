import Control.Monad (replicateM)
import Data.List (mapAccumL)
import Data.Maybe (catMaybes)
import Text.Read (readMaybe)

runCommands :: [String] -> [String]
runCommands commands = catMaybes rawOutputs
    where
        (_, rawOutputs) = mapAccumL step 0 commands

        step :: Int -> String -> (Int, Maybe String)
        step balance line = case words line of
            ["deposit", x] | Just amt <- readMaybe x, amt >= 0 -> 
                (balance + amt, Nothing)
            ["withdraw", x] | Just amt <- readMaybe x, amt >= 0 ->
                if amt > balance
                    then (balance, Just "error")
                    else (balance - amt, Nothing)
            ["balance"] ->
                (balance, Just (show balance))
            _ ->
                (balance, Nothing)

main :: IO ()
main = do
    n <- readLn
    commands <- replicateM n getLine
    putStr (unlines (runCommands commands))
