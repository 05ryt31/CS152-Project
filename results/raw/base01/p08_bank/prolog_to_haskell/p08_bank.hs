import System.IO
import Data.List.Split

main :: IO ()
main = do
    contents <- getContents
    let lines' = lines contents
        n = read $ head lines'
        balance = commands (tail lines') 0
    putStr balance
    return ()

commands :: [String] -> Int -> String
commands [] _ = ""
commands (line:lines') balance =
    let parts = splitOn " " line
        newBalance = case parts of
            ["deposit", amount] -> balance + read amount
            ["withdraw", amount] ->
                if read amount > balance then "error\n" ++ commands lines' balance
                else commands lines' (balance - read amount)
            ["balance"] -> show balance ++ "\n"
    in newBalance ++ commands lines' newBalance
