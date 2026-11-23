groupby :: Ord k => [(k,v)] -> [(k,[v])]
groupby = map (\(x,y)->(x,concat y)) . groupBy ((==) `on` fst) . sortBy (compare `on` fst)
 
main = do
  putStrLn $ unlines $ show <$> groupby [("a",1),("b",3),("a",5),("b",7)]
