import System.IO

parseLine :: String -> [Int]
parseLine = map read . words

mergeSorted :: [Int] -> [Int] -> [Int]
mergeSorted [] ys = ys
mergeSorted xs [] = xs
mergeSorted (x:xs) (y:ys)
  | x <= y    = x : mergeSorted xs (y:ys)
  | otherwise = y : mergeSorted (x:xs) ys

main :: IO ()
main = do
  input <- getContents
  let lines = lines input
      a = parseLine $ head lines
      b = parseLine $ lines !! 1
      merged = mergeSorted a b
  putStr $ unwords (map show merged ++ ["\n"])
