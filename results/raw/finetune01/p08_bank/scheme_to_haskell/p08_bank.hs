import System.IO
 
bank :: Int -> IO ()
bank n = do
  hSetBuffering stdin NoBuffering
  putStrLn $ "Initial balance is " ++ show n
  bank' n
 
bank' :: Int -> IO ()
bank' balance = do
  putStr "> "
  cmd <- getLine
  case words cmd of
    ["deposit", amt] ->
      let newBalance = balance + read amt in
      putStrLn ("New balance is " ++ show newBalance) >> bank' newBalance
    ["withdraw", amt] ->
      if balance < read amt then
        putStrLn "Error" >> bank' balance
      else
        let newBalance = balance - read amt in
        putStrLn ("New balance is " ++ show newBalance) >> bank' newBalance
    _ -> bank' balance
 
main :: IO ()
main = bank 0
