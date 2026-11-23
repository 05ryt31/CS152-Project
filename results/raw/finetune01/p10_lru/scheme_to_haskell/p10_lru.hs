import Data.List.Split (splitOn)
import qualified Data.Map.Strict as M
 
type Cache = M.Map String Int
 
-- | Returns the cache size and the number of operations
parseInput :: String -> (Int, Int)
parseInput str =
  let [cacheSize, numOps] = map read $ splitOn " " $ head $ lines str
      _ = length $ tail $ lines str == numOps
  in (cacheSize, numOps)
 
-- | Returns the cache and the list of operations
parseCache :: String -> (Cache, [(String, Maybe Int)])
parseCache str =
  let (_, numOps) = parseInput str
      ops = take numOps $ map parseOp $ tail $ lines str
  in (M.empty, ops)
 
-- | Parses a single operation
parseOp :: String -> (String, Maybe Int)
parseOp str =
  let [cmd, key, val] = splitOn " " str
      k = read key
      v = if cmd == "set" then Just $ read val else Nothing
  in (k, v)
 
-- | Performs a get operation
doGet :: Cache -> String -> Cache
doGet cache key =
  case M.lookup key cache of
    Just val -> doPut cache key val
    Nothing -> cache
 
-- | Performs a put operation
doPut :: Cache -> String -> Int -> Cache
doPut cache key val =
  let cache' = M.insert key val cache
  in if M.size cache' > maxSize
     then M.delete (head keys) cache'
     else cache'
  where
    maxSize = 3 -- hardcoded for this example
    keys = M.keys cache'
 
-- | Runs all the operations on the given cache
runCache :: Cache -> [(String, Maybe Int)] -> Cache
runCache cache ops =
  foldr (\(key, val) acc ->
           case val of
             Just x -> doPut acc key x
             Nothing -> doGet acc key) cache ops
 
-- | Prints out the final state of the cache
showCache :: Cache -> IO ()
showCache cache =
  putStrLn $ unlines $
  map (\x -> show x ++ ": " ++ show (M.findWithDefault (-1) x cache)) [1..3]
 
main :: IO ()
main = do
  str <- readFile "input.txt"
  let (cache, ops) = parseCache str
  runCache cache ops >>= showCache
