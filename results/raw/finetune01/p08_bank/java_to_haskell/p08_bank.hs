import Control.Monad.Trans.State
 
bank :: StateT Int IO ()
bank = do
  putStrLn "Enter command:"
  cmd <- getLine
  case words cmd of
    ["deposit", amt] -> modify (+ read amt)
    ["withdraw", amt] -> do
      bal <- get
      if bal >= read amt then modify ((-) $ read amt) else liftIO $ putStrLn "Error"
    ["balance"] -> do
      bal <- get
      liftIO $ print bal
    _ -> return ()
  bank
 
main :: IO ()
main = execStateT bank 0
