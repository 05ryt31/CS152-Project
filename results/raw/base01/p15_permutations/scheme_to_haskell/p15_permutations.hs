import Data.List (sort, delete)
import System.IO (hGetContents, stdout)

main :: IO ()
main = do
    contents <- hGetContents stdin
    let letters = sort $ map head $ lines contents
    generate [] letters
    return ()

generate :: [Char] -> [Char] -> IO ()
generate prefix remaining = if null remaining
    then putStrLn $ reverse prefix
    else do
        mapM_ (\letter -> generate (letter : prefix) (delete letter remaining)) remaining
