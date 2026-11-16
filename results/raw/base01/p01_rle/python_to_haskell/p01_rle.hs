import System.IO

main :: IO ()
main = do
    line <- getLine
    let result = compress line
    putStr result

compress :: String -> String
compress [] = []
compress s = go s
  where
    go "" = []
    go xs = c : show n ++ go rest
      where
        (c, n, rest) = span (== c) xs
