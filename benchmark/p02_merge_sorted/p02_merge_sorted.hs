import Control.Monad (unless)
import System.IO (isEOF)

readNums :: String -> [Int]
readNums s = map read (words s)

merge :: [Int] -> [Int] -> [Int]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys) | x <= y = x : merge xs (y:ys)
                    | otherwise = y : merge (x:xs) ys

safeGetLine :: IO String
safeGetLine = do
    eof <- isEOF
    if eof
        then pure ""
        else getLine

main :: IO ()
main = do
    a <- safeGetLine
    b <- safeGetLine
    let result = merge (readNums a) (readNums b)
    unless (null result) (putStrLn (unwords (map show result)))
