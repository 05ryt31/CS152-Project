module Main where

import Data.List (find)
import Control.Monad (when)

main :: IO ()
main = do
    input <- getContents
    let lines' = lines input
        values = map read . words $ head lines'
        commands = tail $ init $ tail lines'
    processCommands values commands >>= print

processCommands :: [Int] -> [String] -> IO (Either String [Int])
processCommands values [] = return $ Right values
processCommands values (command:rest) = case words command of
    ["map", op, amount] ->
        let amount' = read amount
            newValues = map (\v -> if op == "add" then v + amount' else v * amount') values
        in processCommands newValues rest
    ["filter", pred, val] ->
        let predicate = case pred of
                "even" -> even
                "odd" -> odd
                _ -> (> read val)
            newValues = filter predicate values
        in processCommands newValues rest
    ["sum"] ->
        return $ Left $ show $ sum values
    ["max"] ->
        return $ Left $ show $ maximum values
    _ -> return $ Left "Invalid command"
