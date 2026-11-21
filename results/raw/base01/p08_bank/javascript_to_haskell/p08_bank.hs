import System.IO

main :: IO ()
main = do
    contents <- getContents
    let lines = lines contents
        n = read $ head lines
        commands = zipWith parseCommand (tail lines) (drop 2 lines)
        finalBalance = foldl applyCommand 0 commands
        output = map showOutput commands ++ [show finalBalance]
    putStr $ unlines output

parseCommand :: String -> String -> (String, Int)
parseCommand command amount = (command, read amount)

applyCommand :: Int -> (String, Int) -> Int
applyCommand balance ("deposit", amount) = balance + amount
applyCommand balance ("withdraw", amount) | amount <= balance = balance - amount
                                          | otherwise = balance
applyCommand balance _ = balance

showOutput :: (String, Int) -> String
showOutput ("withdraw", amount) | amount > 0 = "error"
showOutput (_, _) = ""
