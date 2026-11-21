import Data.Char (isDigit)
import System.IO

main :: IO ()
main = do
    hSetBuffering stdin NoBuffering
    hSetBuffering stdout NoBuffering
    n <- readLn
    replicateM_ n $ do
        line <- getLine
        if balanced line then putStrLn "yes" else putStrLn "no"

balanced :: String -> Bool
balanced = go []
  where
    go :: [Char] -> String -> Bool
    go stack [] = null stack
    go stack (c:cs)
      | c == '(' || c == '[' || c == '{' = go (c:stack) cs
      | otherwise = case stack of
          [] -> False
          (d:ds) -> if matching d c then go ds cs else False

matching :: Char -> Char -> Bool
matching '(' ')' = True
matching '[' ']' = True
matching '{' '}' = True
matching _ _     = False
