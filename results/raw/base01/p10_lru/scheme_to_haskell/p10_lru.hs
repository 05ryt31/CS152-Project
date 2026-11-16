import Data.List (delete, find, isPrefixOf, tails)
import System.IO (hSetBuffering, stdin, stdout, BufferMode(..))
import Text.Read (readsPrec)

main :: IO ()
main = do
    hSetBuffering stdin LineBuffering
    hSetBuffering stdout NoBuffering
    capacity <- readLn
    n <- readLn
    lru capacity n

lru :: Int -> Int -> IO ()
lru capacity n = go 0 [] []
  where
    go i entries order
      | i == n = return ()
      | otherwise = do
          line <- getLine
          let [op, key] = words line
              key' = read key
          case op of
            "get" -> do
              case find (\(k, _) -> k == key') entries of
                Just (_, v) -> print v
                Nothing     -> print (-1)
              go (i + 1) entries (if Just (_, v) <- find (\(k, _) -> k == key') entries then touch key' order else order)
            _ -> do
              let value = read (head $ tail $ words line)
                  existing = find (\(k, _) -> k == key') entries
                  newEntries = (key', value) : delete (key', value) entries
                  newOrder = touch key' order
              if not (isJust existing) && length newOrder > capacity
                then do
                  let oldest = head newOrder
                  go (i + 1) (delete (oldest, value) newEntries) (tail newOrder)
                else
                  go (i + 1) newEntries newOrder

touch :: Eq a => a -> [a] -> [a]
touch x xs = delete x xs ++ [x]
