import Data.List (group)
 
encode :: Eq a => [a] -> [(Int, a)]
encode = map (\x -> (length x, head x)) . group
 
decode :: Eq a => [(Int, a)] -> [a]
decode = concatMap (uncurry replicate)
 
main :: IO ()
main = do
  putStrLn "Enter string:"
  s <- getLine
  let encoded = encode s
  putStrLn $ "Encoded: " ++ show encoded
  putStrLn $ "Decoded: " ++ decode encoded
