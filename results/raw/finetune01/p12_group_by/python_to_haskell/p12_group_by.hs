import Data.List (groupBy)
 
groupBy_ :: Eq a => [a] -> [[a]]
groupBy_ = groupBy ((==) `on` head)
 
main :: IO ()
main =
  mapM_
    putStrLn
    . concatMap
      (\(x:xs) ->
         [ show x,
           " ",
           show $ sum xs,
           " ",
           show $ length xs + 1
         ])
    . map (map read . tail)
    . groupBy_
    . lines
