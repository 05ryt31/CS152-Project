import Data.List.Split (splitOn)
import System.IO

numbers :: String -> [Int]
numbers line = if null line then [] else map read $ splitOn " " line

merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
  | x <= y    = x : merge xs (y:ys)
  | otherwise = y : merge (x:xs) ys

printList :: Show a => [a] -> IO ()
printList = putStr . unwords . map show

safeReadLine :: IO String
safeReadLine = do
  line <- getLine
  return $ if null line then "" else line

main :: IO ()
main = do
  line1 <- safeReadLine
  line2 <- safeReadLine
  printList $ merge (numbers line1) (numbers line2)
