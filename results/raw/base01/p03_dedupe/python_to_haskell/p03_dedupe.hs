import Data.Set (Set, insert, member, empty)

main :: IO ()
main = do
    line <- getLine
    let tokens = words line
        uniqueValues = foldl processToken (empty, []) tokens
        result = unwords . map show $ snd uniqueValues
    putStr result

processToken :: (Set Int, [Int]) -> String -> (Set Int, [Int])
processToken (seen, acc) token = 
    let value = read token
    in if member value seen then (seen, acc) else (insert value seen, value : acc)
