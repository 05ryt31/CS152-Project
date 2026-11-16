import Data.List (sortOn)
import System.IO

data Group = Group { key :: Int, sum :: Int, count :: Int } deriving (Ord)

instance Show Group where
    show (Group k s c) = show k ++ " " ++ show s ++ " " ++ show c

parseInput :: String -> [(Int, Int)]
parseInput = map parseLine . lines
  where
    parseLine line = let [keyStr, valueStr] = words line in
                      (read keyStr, read valueStr)

groupByKey :: [(Int, Int)] -> [Group]
groupByKey = foldl' groupByAcc []
  where
    groupByAcc acc (k, v) =
      case find (\g -> key g == k) acc of
        Just g -> acc \\ [g] ++ [Group k (sum g + v) (count g + 1)]
        Nothing -> acc ++ [Group k v 1]

formatOutput :: [Group] -> String
formatOutput = unlines . map show

main :: IO ()
main = do
  hSetBuffering stdin NoBuffering
  hSetBuffering stdout NoBuffering
  input <- getContents
  let groups = sortOn key $ groupByKey $ parseInput input
  putStr $ formatOutput groups
  exitSuccess
