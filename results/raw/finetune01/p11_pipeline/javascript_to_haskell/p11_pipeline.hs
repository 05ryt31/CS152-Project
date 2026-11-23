import Data.List.Split (splitOn)
 
pipeline :: [String] -> Int -> String
pipeline xs n =
  let fns = take n $ map parseFn $ drop 2 xs
      vals = read <$> splitOn " " (head xs)
  in show . foldl applyFns vals $ fns
  where
    parseFn s =
      case words s of
        ["map", "add", v] -> \xs -> (+) (read v) <$> xs
        ["map", "mul", v] -> (*) (read v) <$> id
        ["filter", "evn"] -> filter even
        ["filter", "odr"] -> filter odd
        ["filter", "gt", v] -> (>)(read v) <$> id
        ["reduce", "sum"] -> sum
        _ -> length
    applyFns = foldl (<*>) <*> id
 
main :: IO ()
main = do
  txt <- readFile "input.txt"
  putStrLn $ pipeline (lines txt) 3
