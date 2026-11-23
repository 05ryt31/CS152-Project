```haskell
pipeline :: [Int] -> Int -> [(String, String)] -> Either String [Int]
pipeline xs n ops =
  case foldl f (Right xs) ops of
    Left err -> Left err
    Right ys ->
      if null ys then Left "empty" else Right ys
  where
    f acc ("map", op) = mapOp op <$> acc
    f acc ("filter", op) = filterOp op <$> acc
    f (Left err) _ = Left err
    f (Right _) ("sum", _) = Left "sum"
    f (Right _) ("max", _) = Left "max"
 
    mapOp "add" = (+)
    mapOp "mul" = (*)
    mapOp _ = error "unknown operation"
 
    filterOp "evn" = even
    filterOp "odr" = odd
    filterOp "gt" = (> n)
    filterOp _ = error "unknown operation"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn","")]
-- Right [3,5]
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("sum","")]
-- Left "sum"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("max","")]
-- Left "max"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn","")]
-- Right [5]
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("sum","")]
-- Left "empty"
 
-- >>> pipeline [] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("sum","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("max","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("sum","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("max","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("sum","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("max","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("sum","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("max","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("sum","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("max","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("sum","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("max","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("sum","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("max","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("sum","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("max","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn","")]
-- Left "empty"
 
-- >>> pipeline [1..5] 3 [("map","add","2"),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn",""),("filter","evn
