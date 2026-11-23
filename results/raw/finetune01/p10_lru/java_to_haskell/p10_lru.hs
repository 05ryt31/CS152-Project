```haskell
import qualified Data.Map.Strict as M
 
lruCache :: Int -> [(String, Int)] -> [Int]
lruCache cap =
  snd .
  foldrWithKey (\k v (m, xs) ->
                  let m' = M.insert k v m
                      xs' = k : filter (/= k) xs
                  in if M.size m' <= cap then (m', xs') else (M.delete eldest m', eldest : xs'))
                (M.empty, [])
  where eldest = head xs
 
main :: IO ()
main = do
  print $ lruCache 3 [("set", 1, 1), ("set", 2, 2), ("get", 1), ("get", 2), ("get", 3)]
  print $ lruCache 3 [("set", 1, 1), ("set", 2, 2), ("set", 3, 3), ("get", 1), ("get", 2), ("get", 3)]
  print $ lruCache 3 [("set", 1, 1), ("set", 2, 2), ("set", 3, 3), ("set", 4, 4), ("get", 1), ("get", 2), ("get", 3), ("get", 4)]
  print $ lruCache 3 [("set", 1, 1), ("set", 2, 2), ("set", 3, 3), ("set", 4, 4), ("set", 5, 5), ("get", 1), ("get", 2), ("get", 3), ("get", 4), ("get", 5)]
  print $ lruCache 3 [("set", 1, 1), ("set", 2, 2), ("set", 3, 3), ("set", 4, 4), ("set", 5, 5), ("set", 6, 6), ("get", 1), ("get", 2), ("get", 3), ("get", 4), ("get", 5), ("get", 6)]
  print $ lruCache 3 [("set", 1, 1), ("set", 2, 2), ("set", 3, 3), ("set", 4, 4), ("set", 5, 5), ("set", 6, 6), ("set", 7, 7), ("get", 1), ("get", 2), ("get", 3), ("get", 4), ("get", 5), ("get", 6), ("get", 7)]
  print $ lruCache 3 [("set", 1, 1), ("set", 2, 2), ("set", 3, 3), ("set", 4, 4), ("set", 5, 5), ("set", 6, 6), ("set", 7, 7), ("set", 8, 8), ("get", 1), ("get", 2), ("get", 3), ("get", 4), ("get", 5), ("get", 6), ("get", 7), ("get", 8)]
  print $ lruCache 3 [("set", 1, 1), ("set", 2, 2), ("set", 3, 3), ("set", 4, 4), ("set", 5, 5), ("set", 6, 6), ("set", 7, 7), ("set", 8, 8), ("set", 9, 9), ("get", 1), ("get", 2), ("get", 3), ("get", 4), ("get", 5), ("get", 6), ("get", 7), ("get", 8), ("get", 9)]
  print $ lruCache 3 [("set", 1, 1), ("set", 2, 2), ("set", 3, 3), ("set", 4, 4), ("set", 5, 5), ("set", 6, 6), ("set", 7, 7), ("set", 8, 8), ("set", 9, 9), ("set", 10, 10), ("get", 1), ("get", 2), ("get", 3), ("get", 4), ("get", 5), ("get", 6), ("get", 7), ("get", 8), ("get", 9), ("get", 10)]
  print $ lruCache 3 [("set", 1, 1), ("set", 2, 2), ("set", 3, 3), ("set", 4, 4), ("set", 5, 5), ("set", 6, 6), ("set", 7, 7), ("set", 8, 8), ("set", 9, 9), ("set", 10, 10), ("set", 11, 11), ("get", 1), ("get", 2), ("get", 3), ("get", 4), ("get", 5), ("get", 6), ("get", 7), ("get", 8), ("get", 9), ("get", 10), ("get", 11)]
  print $ lruCache 3 [("set", 1, 1), ("set", 2, 2), ("set", 3, 3), ("set", 4, 4), ("set", 5, 5), ("set", 6, 6), ("set", 7, 7), ("set", 8, 8), ("set", 9, 9), ("set", 10, 10), ("set", 11, 11), ("set", 12, 12), ("get", 1), ("get", 2), ("get", 3), ("get", 4), ("get", 5), ("get", 6), ("get", 7), ("get", 8), ("get", 9), ("get", 10), ("get", 11), ("get", 12)]
  print $ lruCache 3 [("set", 1, 1), ("set", 2, 2), ("set", 3, 3), ("set", 4, 4), ("set", 5, 5), ("set", 6, 6), ("set", 7, 7), ("set", 8, 8), ("set", 9, 9), ("set", 10, 10), ("set", 11, 11), ("set", 12, 12), ("set", 13, 13), ("get", 1), ("get", 2), ("get", 3), ("get", 4), ("get", 5), ("get", 6), ("get", 7), ("get", 8), ("get", 9), ("get", 10), ("get", 11), ("get", 12), ("get", 13)]
  print $ lruCache 3 [("set", 1, 1), ("set", 2, 2), ("set", 3, 3), ("set", 4, 4), ("set", 5, 5), ("set", 6, 6), ("set", 7, 7), ("set", 8, 8), ("set", 9, 9), ("set", 10, 10), ("set", 11, 11), ("set", 12, 12), ("set", 13, 13), ("set", 14, 14), ("get", 1), ("get", 2), ("get", 3), ("get", 4), ("get", 5), ("get", 6), ("get", 7), ("get", 8), ("get", 9), ("get", 10), ("get", 11), ("get", 12), ("get", 13), ("get", 14)]
  print $ lruCache 3 [("set", 1, 1), ("set", 2, 2), ("set", 3, 3), ("set", 4, 4), ("set", 5, 5), ("set", 6, 6), ("set", 7, 7), ("set", 8, 8), ("set", 9, 9), ("set", 10, 10), ("set", 11, 11), ("set", 12, 12), ("set", 13, 13), ("set", 14, 14), ("set", 15, 15), ("get", 1), ("get", 2), ("get", 3), ("get", 4), ("get", 5), ("get", 6), ("get", 7), ("get", 8), ("get", 9),
