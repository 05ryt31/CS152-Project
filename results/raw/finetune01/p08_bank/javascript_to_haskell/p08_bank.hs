import System.IO
 
bank :: String -> Int -> IO ()
bank command balance =
  case words command of
    ["balance"] -> putStrLn $ show balance
    ["deposit", s] -> bank "balance" $ balance + read s
    ["withdraw", s]
      | balance >= read s -> bank "balance" $ balance - read s
      | otherwise -> putStrLn "Insufficient funds"
    _ -> putStrLn "Invalid command"
 
main :: IO ()
main = do
  hSetBuffering stdin LineBuffering
  putStrLn "Enter commands:"
  command <- getLine
  bank command 0
