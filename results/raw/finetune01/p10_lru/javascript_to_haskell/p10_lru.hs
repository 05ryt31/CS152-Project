import qualified Data.Map.Strict as M
 
lruCache :: Int -> [(String, Integer)] -> [Maybe Integer]
lruCache cap cache =
  let go [] _ m = []
      go ((cmd, k):xs) r m
        | cmd == "set" = case M.lookup k m of
          Just v -> go xs r $ M.insert k v m
          Nothing ->
            if length m >= cap then
              let (k', m') = head m in go xs r $ M.insert k r m'
            else go xs r $ M.insert k r m
        | otherwise = case M.lookup k m of
          Just v -> go xs v m
          Nothing -> go xs Nothing m
  in map snd $ go cache Nothing M.empty
 
main :: IO ()
main = do
  input <- getContents
  let (cap:n:cache:_) = words <$> lines input
  putStrLn $ unlines $ show <$> lruCache (read cap) (zip (words n) (map read . words <$> tail cache))
