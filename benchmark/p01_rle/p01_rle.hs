import Data.List (group)

main :: IO ()
main = do
    line <- getLine
    putStrLn $ concatMap (\g -> head g : show (length g)) (group line)
