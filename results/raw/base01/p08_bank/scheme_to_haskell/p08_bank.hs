import System.IO
import Data.List.Split

bank :: Int -> IO ()
bank n = do
    lines <- getContents
    let commands = map words $ lines
    loop 0 0 commands
  where
    loop :: Int -> Int -> [[String]] -> IO ()
    loop _ _ [] = return ()
    loop i balance ((command:args):rest)
      | command == "deposit" = loop (i + 1) (balance + read args) rest
      | command == "withdraw" = do
          let amount = read args
          if amount > balance then do
              putStrLn "error"
              loop (i + 1) balance rest
          else
              loop (i + 1) (balance - amount) rest
      | otherwise = do
          print balance
          loop (i + 1) balance rest

main :: IO ()
main = do
    n <- readLn
    bank n
