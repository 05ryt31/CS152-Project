```haskell
import Data.List.Split (splitOn)
 
-- | A pipeline is a list of stages.
type Pipeline = [Stage]
 
-- | A stage is either a filter or a map.
data Stage = Filter String Int | Map String Int deriving Show
 
-- | A value is either a number or a boolean.
data Value = Number Int | Boolean Bool deriving Show
 
-- | A function that takes a pipeline and a list of numbers and returns the result.
pipeline :: Pipeline -> [Int] -> [Value]
pipeline [] _ = []
pipeline (Filter s n : xs) ns =
  case s of
    "even" -> pipeline xs $ filter (\x -> x `mod` 2 == 0) ns
    "odd" -> pipeline xs $ filter (\x -> x `mod` 2 /= 0) ns
    _ -> pipeline xs $ filter (\x -> x > n) ns
pipeline (Map s n : xs) ns =
  case s of
    "add" -> pipeline xs $ map (+ n) ns
    "mul" -> pipeline xs $ map (* n) ns
 
-- | A function that takes a string and returns a pipeline.
parsePipeline :: String -> Pipeline
parsePipeline = parse . splitOn " "
  where
    parse ["end"] = []
    parse ("filter":s:n:xs) = Filter s (read n) : parse xs
    parse ("map":s:n:xs) = Map s (read n) : parse xs
 
-- | A function that takes a pipeline and a list of numbers and prints the result.
showResult :: Pipeline -> [Int] -> IO ()
showResult p ns = do
  let r = pipeline p ns
  putStrLn $ show r
 
-- | A function that takes a pipeline and a list of numbers and returns the maximum value.
maxResult :: Pipeline -> [Int] -> Maybe Int
maxResult p ns = case pipeline p ns of
  [] -> Nothing
  (Number n:_) -> Just n
  _ -> Nothing
 
-- | A function that takes a pipeline and a list of numbers and returns the sum of all values.
sumResult :: Pipeline -> [Int] -> Maybe Int
sumResult p ns = case pipeline p ns of
  [] -> Nothing
  (Number n:ns') -> Just $ n + maybe 0 id (sumResult p ns')
  _ -> Nothing
 
-- | A function that takes a pipeline and a list of numbers and returns the first value.
firstResult :: Pipeline -> [Int] -> Maybe Int
firstResult p ns = case pipeline p ns of
  [] -> Nothing
  (Number n:_) -> Just n
  _ -> Nothing
 
-- | A function that takes a pipeline and a list of numbers and returns the last value.
lastResult :: Pipeline -> [Int] -> Maybe Int
lastResult p ns = case pipeline p ns of
  [] -> Nothing
  (Number n:[]) -> Just n
  (_:ns') -> lastResult p ns'
  _ -> Nothing
 
-- | A function that takes a pipeline and a list of numbers and returns the second-to-last value.
secondLastResult :: Pipeline -> [Int] -> Maybe Int
secondLastResult p ns = case pipeline p ns of
  [] -> Nothing
  (Number n:[]) -> Just n
  (Number _:n:[]) -> Just n
  (_:_:ns') -> secondLastResult p ns'
  _ -> Nothing
 
-- | A function that takes a pipeline and a list of numbers and returns the third-to-last value.
thirdLastResult :: Pipeline -> [Int] -> Maybe Int
thirdLastResult p ns = case pipeline p ns of
  [] -> Nothing
  (Number n:[]) -> Just n
  (Number _:n:[]) -> Just n
  (Number _:_:n:[]) -> Just n
  (_:_:_:ns') -> thirdLastResult p ns'
  _ -> Nothing
 
-- | A function that takes a pipeline and a list of numbers and returns the fourth-to-last value.
fourthLastResult :: Pipeline -> [Int] -> Maybe Int
fourthLastResult p ns = case pipeline p ns of
  [] -> Nothing
  (Number n:[]) -> Just n
  (Number _:n:[]) -> Just n
  (Number _:_:n:[]) -> Just n
  (Number _:_:_:n:[]) -> Just n
  (_:_:_:_:ns') -> fourthLastResult p ns'
  _ -> Nothing
 
-- | A function that takes a pipeline and a list of numbers and returns the fifth-to-last value.
fifthLastResult :: Pipeline -> [Int] -> Maybe Int
fifthLastResult p ns = case pipeline p ns of
  [] -> Nothing
  (Number n:[]) -> Just n
  (Number _:n:[]) -> Just n
  (Number _:_:n:[]) -> Just n
  (Number _:_:_:n:[]) -> Just n
  (Number _:_:_:_:n:[]) -> Just n
  (_:_:_:_:_:ns') -> fifthLastResult p ns'
  _ -> Nothing
 
-- | A function that takes a pipeline and a list of numbers and returns the sixth-to-last value.
sixthLastResult :: Pipeline -> [Int] -> Maybe Int
sixthLastResult p ns = case pipeline p ns of
  [] -> Nothing
  (Number n:[]) -> Just n
  (Number _:n:[]) -> Just n
  (Number _:_:n:[]) -> Just n
  (Number _:_:_:n:[]) -> Just n
  (Number _:_:_:_:n:[]) -> Just n
  (Number _:_:_:_:_:n:[]) -> Just n
  (_:_:_:_:_:_:ns') -> sixthLastResult p ns'
  _ -> Nothing
 
-- | A function that takes a pipeline and a list of numbers and returns the seventh-to-last value.
seventhLastResult :: Pipeline -> [Int] -> Maybe Int
seventhLastResult p ns = case pipeline p ns of
  [] -> Nothing
  (Number n:[]) -> Just n
  (Number _:n:[]) -> Just n
  (Number _:_:n:[]) -> Just n
  (Number _:_:_:n:[]) -> Just n
  (Number _:_:_:_:n:[]) -> Just n
  (Number _:_:_:_:_:n:[]) -> Just n
  (Number _:_:_:_:_:_:n:[]) -> Just n
  (_:_:_:_:_:_:_:ns') -> seventhLastResult p ns'
  _ -> Nothing
 
-- | A function that takes a pipeline and a list of numbers and returns the eighth-to-last value.
eighthLastResult :: Pipeline -> [Int] -> Maybe Int
eighthLastResult p ns = case pipeline p ns of
  [] -> Nothing
  (Number n:[]) -> Just n
  (Number _:n:[]) -> Just n
  (Number _:_:n:[]) -> Just n
  (Number _:_:_:n:[]) -> Just n
  (Number _:_:_:_:n:[]) -> Just n
  (Number _:_:_:_:_:n:[]) -> Just n
  (Number _:_:_:_:_:_:n:[]) -> Just n
  (Number _:_:_:_:_:_:_:n:[]) -> Just n
  (_:_:_:_:_:_:_:_:ns') -> eighthLastResult p ns'
  _ -> Nothing
 
-- | A function that takes a pipeline and a list of numbers and returns the ninth-to-last value.
ninthLastResult :: Pipeline -> [Int] -> Maybe Int
ninthLastResult p ns = case pipeline p ns of
  [] -> Nothing
  (Number n:[]) -> Just n
  (Number _:n:[]) -> Just n
  (Number _:_:n:[]) -> Just n
  (Number _:_:_:n:[]) -> Just n
  (Number _:_:_:_:n:[]) -> Just n
  (Number _:_:_:_:_:n:[]) -> Just n
  (Number _:_:_:_:_:_:n:[]) -> Just n
  (Number _:_:_:_:_:_:_:n:[]) -> Just n
  (Number _:_:_:_:_:_:_:_:n:[]) -> Just n
  (_:_:_:_:_:_:_:_:_:ns') -> ninthLastResult p ns'
  _ -> Nothing
 
-- | A function that takes a pipeline and a list of numbers and returns the tenth-to-last value.
tenthLastResult :: Pipeline -> [Int] -> Maybe Int
tenthLastResult p ns = case pipeline p ns of
  [] -> Nothing
  (Number n:[]) -> Just n
  (Number _:n:[]) -> Just n
  (Number _:_:n:[]) -> Just n
  (Number _:_:_:n:[]) -> Just n
  (Number _:_:_:_:n:[]) -> Just n
  (Number _:_:_:_:_:n:[]) -> Just n
  (Number _:_:_:_:_:_:n:[]) -> Just n
  (Number _:_:_:_:_:_:_:n:[]) -> Just n
  (Number _:_:_:_:_:_:_:_:n:[]) -> Just n
  (Number _:_:_:_:_:_:_:_:_:n:[]) -> Just n
  (_:_
