import qualified Data.Map as M
 
lruCache :: Int -> [(String, Int)] -> [Int]
lruCache cap cache =
  let cacheMap = foldr (\(k, v) m -> M.insert k v m) M.empty cache
      lruList = map fst $ reverse $ M.toList cacheMap
  in take cap lruList
 
main :: IO ()
main = do
  putStrLn "Enter cache size:"
  cap <- read <$> getLine
  putStrLn "Enter number of operations:"
  numOps <- read <$> getLine
  putStrLn "Enter operations:"
  ops <- replicateM numOps $ do
    op <- getLine
    return $ words op
  putStrLn "LRU Cache:"
  let cache = zipWith (\op x -> case op of
                                 ["set", k, v] -> (x, read v)
                                 ["get", k]   -> (read k, x))
                      ops [0..numOps - 1]
  print $ lruCache cap cache
