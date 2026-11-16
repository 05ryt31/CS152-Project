import System.IO
import Data.List (select, findIndex)
import Data.Maybe (fromJust)

main :: IO ()
main = do
    hSetBuffering stdin NoBuffering
    hSetBuffering stdout NoBuffering
    cLine <- getLine
    nLine <- getLine
    let c = read cLine :: Int
        n = read nLine :: Int
    run n c []

run :: Int -> Int -> [(Int, String)] -> IO ()
run 0 _ _ = return ()
run n c cache = do
    line <- getLine
    let parts = words line
    operation parts c cache
    run (n - 1) c cache

operation :: [String] -> Int -> [(Int, String)] -> IO ()
operation ["get", k] _ cache = do
    case findIndex ((== read k) . fst) cache of
        Just idx -> do
            putStrLn $ snd $ cache !! idx
            print $ take idx cache ++ drop (idx + 1) cache ++ [(read k, snd $ cache !! idx)]
        Nothing -> do
            putStrLn "-1"
            print cache

operation ["put", k, v] 0 _ = return ()
operation ["put", k, v] c cache = do
    case findIndex ((== read k) . fst) cache of
        Just idx -> do
            print $ take idx cache ++ drop (idx + 1) cache ++ [(read k, v)]
        Nothing -> do
            if length cache >= c
                then do
                    let (front, _) = splitAt (c - 1) cache
                    print $ front ++ [(read k, v)]
                else
                    print $ cache ++ [(read k, v)]
