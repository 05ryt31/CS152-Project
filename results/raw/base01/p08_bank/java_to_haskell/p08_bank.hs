module Main where

import Control.Monad (when)
import Data.Char (isDigit)

main :: IO ()
main = do
    input <- getContents
    let lines' = lines input
        n = read $ head lines'
        transactions = tail lines'
    processTransactions n transactions

processTransactions :: Int -> [String] -> IO ()
processTransactions _ [] = return ()
processTransactions balance ("deposit " ++ amount : xs) = 
    let amt = read amount
    in processTransactions (balance + amt) xs
processTransactions balance ("withdraw " ++ amount : xs) = 
    let amt = read amount
    in when (amt > balance) (putStrLn "error") >> processTransactions (balance - amt) xs
processTransactions balance ("balance" : xs) = 
    putStrLn (show balance) >> processTransactions balance xs
