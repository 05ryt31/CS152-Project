import Data.List (sort, sortBy, find)
import Data.Maybe (fromJust)
import System.IO (hGetContents, stdout)
import Text.Read (readMaybe)

type Group = (String, Int, Int)

main :: IO ()
main = do
    contents <- hGetContents stdin
    let lines' = lines contents
    let n = readMaybe (head lines') :: Maybe Int
    case n of
        Just n -> do
            let groups = readGroups (tail lines')
            printGroups $ sortBy (\(a, _, _) (b, _, _) -> compare a b) groups
        Nothing -> putStrLn "Invalid input"

readGroups :: [String] -> [Group]
readGroups = foldl update []
  where
    update groups line = case words line of
        [key, value] -> let key' = head key in
                         case find ((== key') . fst) groups of
                             Just (_, v, c) -> (key', v + read value, c + 1) : without key' groups
                             Nothing       -> (key', read value, 1) : groups
        _             -> groups

without :: String -> [Group] -> [Group]
without key = filter ((/= key) . fst)

printGroups :: [Group] -> IO ()
printGroups = mapM_ (\(k, v, c) -> putStrLn $ k ++ " " ++ show v ++ " " ++ show c)
