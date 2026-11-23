import System.IO
 
bank :: IO ()
bank = do
  hSetBuffering stdin NoBuffering
  putStrLn "Welcome to the bank!"
  putStrLn "Enter your name:"
  name <- getLine
  putStrLn $ "Hello " ++ name ++ ", what would you like to do?"
  loop name
  where
    loop name = do
      cmd <- getLine
      case cmd of
        "exit" -> return ()
        "balance" -> do
          putStrLn $ "Your current balance is " ++ show balance ++ "."
          loop name
        "deposit" -> do
          putStrLn "How much would you like to deposit?"
          amt <- read <$> getLine
          let balance' = balance + amt
          putStrLn $ "You have deposited " ++ show amt ++ ". Your new balance is " ++ show balance'
          loop name
        "withdraw" -> do
          putStrLn "How much would you like to withdraw?"
          amt <- read <$> getLine
          if amt <= balance then do
            let balance' = balance - amt
            putStrLn $ "You have withdrawn " ++ show amt ++ ". Your new balance is " ++ show balance'
            loop name
          else do
            putStrLn "Insufficient funds."
            loop name
        _ -> do
          putStrLn "Invalid command."
          loop name
    balance = 1000 -- initial balance
 
main :: IO ()
main = bank
