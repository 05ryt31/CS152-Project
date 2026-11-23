import Data.List.Split (splitOn)
 
pipeline :: String -> Int -> [Int] -> Maybe [Int]
pipeline = pipeline'
 
pipeline' :: String -> Int -> [Int] -> Maybe [Int]
pipeline' _ 0 xs = Just xs
pipeline' s k xs =
  case parseStage $ head $ lines s of
    Nothing -> Nothing
    Just stage ->
      case stage xs of
        Nothing -> Nothing
        Just ys -> pipeline' (tail s) (k - 1) ys
 
parseStage :: String -> Maybe ([Int] -> Maybe [Int])
parseStage s =
  case words s of
    ["map", "add", n] -> Just $ fmap ((read n+) . read)
    ["map", "mul", n] -> Just $ fmap ((read n*) . read)
    ["filter", "even"] -> Just $ Just . filter even . fmap read
    ["filter", "odd"] -> Just $ Just . filter odd . fmap read
    ["filter", "gt", n] -> Just $ Just . filter (> read n) . fmap read
    ["reduce", "sum"] -> Just $ Just . pure . sum . fmap read
    ["reduce", "max"] -> Just $ Just . pure . maximum . fmap read
    _ -> Nothing
 
main :: IO ()
main = do
  putStrLn "Enter the pipeline:"
  pipeline <- getLine
  putStrLn "Enter the number of stages:"
  numStages <- read <$> getLine
  putStrLn "Enter the values:"
  values <- read <$> getLine
  case pipeline pipeline numStages values of
    Nothing -> putStrLn "Pipeline failed"
    Just v -> print v
