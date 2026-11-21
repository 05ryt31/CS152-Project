import Data.Map.Strict (Map, empty, insert, delete, member, lookup)
import System.IO (hSetBuffering, stdin, stdout, BufferMode(..))
import Control.Monad (when)

main :: IO ()
main = do
    hSetBuffering stdin LineBuffering
    hSetBuffering stdout NoBuffering
    input <- getContents
    let lines' = lines input
        capacity = read $ head lines'
        n = read $ lines' !! 1
        commands = zipWith parseCommand [3..] (drop 2 lines')
    processCommands capacity commands

parseCommand :: Int -> String -> (Int, Int, Maybe Int)
parseCommand _ ('g':'e':'t':':':xs) = (0, read xs, Nothing)
parseCommand _ ('s':'e':'t':':':xs) = case words xs of
    [k, v] -> (1, read k, Just (read v))
    _ -> error "Invalid set command"
parseCommand _ _ = error "Invalid command"

processCommands :: Int -> [(Int, Int, Maybe Int)] -> IO ()
processCommands cap cmds = do
    let (outputs, _) = foldl processCmd (empty, []) cmds
    mapM_ putStrLn outputs

processCmd :: (Map Int Int, [String]) -> (Int, Int, Maybe Int) -> (Map Int Int, [String])
processCmd (cache, acc) (cmdType, key, val) = case cmdType of
    0 -> case lookup key cache of
        Just value -> (cache, acc ++ [show value])
        Nothing -> (cache, acc ++ ["-1"])
    1 -> case (member key cache, size cache) of
        (True, _) -> (insert key (fromJust val) cache, acc)
        (False, s) | s == cap -> (delete oldestKey (insert key (fromJust val) cache), acc)
                    | otherwise -> (insert key (fromJust val) cache, acc)
    _ -> error "Invalid command type"
  where
    oldestKey = fst . head $ toList cache
    fromJust (Just x) = x
