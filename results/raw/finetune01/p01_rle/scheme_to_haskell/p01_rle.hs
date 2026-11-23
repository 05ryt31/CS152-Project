import Data.List (group)
 
rleEncode :: Eq a => [a] -> [(Int, a)]
rleEncode = map (length &&& head) . group
 
main :: IO ()
main = do
  putStrLn $ show $ rleEncode "mississippi"
  putStrLn $ show $ rleEncode [1,2,3,3,3,3,4,5,5]
