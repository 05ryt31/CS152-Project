import Data.List (nub)
 
main = do
  putStrLn $ unwords . nub . words <$> getLine
