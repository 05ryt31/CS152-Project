import qualified Data.Set as Set
import Control.Monad (unless)
import System.IO (isEOF)

readNums :: String -> [Int]
readNums s = map read (words s)

unique :: [Int] -> [Int]
unique = loop Set.empty
    where
        loop :: Set.Set Int -> [Int] -> [Int]
        loop _ [] = []
        loop seen (x:xs) | Set.member x seen = loop seen xs
                         | otherwise = x : loop (Set.insert x seen) xs

safeGetLine :: IO String
safeGetLine = do
    eof <- isEOF
    if eof
        then pure ""
        else getLine

main :: IO ()
main = do
    line <- safeGetLine
    let result = unique (readNums line)
    unless (null result) (putStrLn (unwords (map show result)))
