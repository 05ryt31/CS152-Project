import Data.List (sort)
import Data.Map (Map, empty, insertWith, keys, lookup)

main :: IO ()
main = do
    input <- getContents
    let lines = lines input
        n = read . head $ lines
        groups = foldl processLine empty (tail lines)
    putStr . unlines $ map formatGroup (sort . keys $ groups)
  where
    processLine acc line = case words line of
        [key, raw] -> insertWith (\(_, c1) (_, c2) -> (c1 + value, c2 + 1)) key (value, 1) acc
        _ -> acc
      where
        value = read raw :: Int
    formatGroup (key, (sumValue, count)) = key ++ " " ++ show sumValue ++ " " ++ show count
