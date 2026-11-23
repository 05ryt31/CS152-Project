import Data.List.Split (splitOn)
import qualified Data.Map.Strict as M
 
type Cache = M.Map String Int
 
-- cache capacity
cacheSize :: Int
cacheSize = 3
 
-- cache contents
cache :: Cache
cache =
  M.fromList $
  zip ["a", "b", "c"] [1, 2, 3]
 
-- get value by key
getValue :: String -> Cache -> Maybe Int
getValue k c = M.lookup k c
 
-- put value by key
putValue :: String -> Int -> Cache -> Cache
putValue k v c = M.insert k v c
 
-- remove least recently used item
removeLRU :: Cache -> Cache
removeLRU c = case M.toList c of
  [] -> c
  ((k, v):xs) -> M.fromList xs
 
-- update cache
updateCache :: String -> Int -> Cache -> Cache
updateCache k v c = case getValue k c of
  Just _ -> putValue k v $ removeLRU c
  Nothing ->
    if M.size c < cacheSize
      then putValue k v c
      else putValue k v $ removeLRU c
 
-- print cache
printCache :: Cache -> IO ()
printCache c = do
  putStrLn "Current cache:"
  mapM_ (\(k, v) -> putStrLn $ k ++ ": " ++ show v) $ M.toList c
 
-- process command
processCommand :: String -> Cache -> Cache
processCommand cmd c = case words cmd of
  ["get", k] -> case getValue k c of
    Just v -> putStrLn ("Value of " ++ k ++ ": " ++ show v) >> c
    Nothing -> putStrLn ("No such key: " ++ k) >> c
  ["put", k, v] -> let i = read v in
    putStrLn ("Put " ++ k ++ "=" ++ show i) >> updateCache k i c
  _ -> error "Invalid command"
 
-- process commands
processCommands :: [String] -> Cache -> Cache
processCommands cmds c = foldl processCommand c cmds
 
-- parse commands
parseCommands :: String -> [String]
parseCommands s = splitOn "\n" s >>= splitOn " "
 
-- main function
main :: IO ()
main = do
  putStrLn "Enter commands:"
  cmds <- getContents
  let cmds' = parseCommands cmds
  putStrLn "Initial cache:"
  printCache cache
  putStrLn "Final cache:"
  printCache $ processCommands cmds' cache
