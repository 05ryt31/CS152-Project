import Data.List (group)
 
rleEncode :: Eq a => [a] -> [(Int, a)]
rleEncode = map (length &&& head) . group
 
main :: IO ()
main =
  interact $
  unwords .
  fmap (\(x, y) -> show x ++ replicate (max 1 x) y) .
  rleEncode .
  filter (/= '\n')
