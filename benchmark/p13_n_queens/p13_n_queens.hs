safe :: [Int] -> Int -> Bool
safe cols col = all (\(c, d) -> c /= col && abs (c - col) /= d) (zip cols [1..])

count :: Int -> Int -> [Int] -> Int
count n row cols
    | row == n = 1
    | otherwise = sum [ count n (row + 1) (col : cols)
                        | col <- [0 .. n - 1]
                        , safe cols col
                        ]

main :: IO ()
main = do
    n <- readLn
    putStrLn (show (count n 0 []))
