import Data.List (intercalate)
 
removeDuplicates :: [Int] -> [Int]
removeDuplicates [] = []
removeDuplicates (x:xs) =
  case elem x xs of
    True -> removeDuplicates xs
    False -> x : removeDuplicates xs
 
main :: IO ()
main = do
  putStrLn "Enter numbers separated by spaces:"
  input <- getLine
  let nums = read <$> words input
      uniqueNums = removeDuplicates nums
  putStrLn $ intercalate " " . show <$> uniqueNums
