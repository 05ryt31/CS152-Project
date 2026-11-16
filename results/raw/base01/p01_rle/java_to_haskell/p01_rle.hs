module Main where

import Data.Char (intToDigit)
import System.IO (getContents, putStr)

main :: IO ()
main = do
    input <- getContents
    let encoded = encode input
    putStr encoded

encode :: String -> String
encode [] = []
encode str = go str
  where
    go "" = ""
    go s = c : show n ++ go rest
      where
        (c:cs) = s
        (n, rest) = span (== c) cs
