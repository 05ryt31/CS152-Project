import Data.List.Split (splitOn)
 
pipeline :: [Int] -> String -> [String] -> [Int]
pipeline xs cmd args =
  case cmd of
    "map" ->
      let amt = read $ head args
       in case args !! 1 of
            "add" -> (+ amt) <$> xs
            "mul" -> (* amt) <$> xs
    "filter" ->
      case args !! 0 of
        "evn" -> filter even xs
        "odr" -> filter odd xs
        "grt" -> filter (> amt) xs
          where
            amt = read $ head args
    "reduce" ->
      case args !! 0 of
        "sml" -> minimum <$> pure xs
        "big" -> maximum <$> pure xs
        "sum" -> sum <$> pure xs
  where
    amt = read $ head args
 
main :: IO ()
main = do
  putStrLn "Enter numbers:"
  nums <- map read . splitOn " " <$> getLine
  putStrLn "Enter number of stages:"
  nStages <- read <$> getLine
  putStrLn "Enter stages:"
  stages <- replicateM nStages $ do
    stage <- getLine
    return $ words stage
  putStrLn "Result:"
  print $ foldl pipeline nums stages
