import System.IO

main :: IO ()
main = do
    hSetBuffering stdin NoBuffering
    hSetBuffering stdout NoBuffering
    n <- readLn
    let processCommand ('d':'e':'p':'o':'s':'i':'t':':':xs) = Just $ \b -> b + read xs
        processCommand ('w':'i':'t':'h':'d':'r':'a':'w':':':xs) = Just $ \b -> 
            let amount = read xs
            in if amount > b then Nothing else Just $ b - amount
        processCommand ('b':'a':'l':'a':'n':'c':'e':':':_) = Just id
        processCommand _ = Nothing
    commands <- replicateM n getLine
    let finalBalance = foldl (\acc cmd -> case processCommand cmd acc of
                                        Just f -> f
                                        Nothing -> acc) 0 commands
    putStrLn $ show finalBalance
