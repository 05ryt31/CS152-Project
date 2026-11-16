import System.IO

main :: IO ()
main = do
    line <- getLine
    let expression = read line :: Int
    print expression
    return ()
