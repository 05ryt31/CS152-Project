import Data.List (sort)

permutations :: [a] -> [[a]]
permutations [] = [[]]
permutations xs = [y : rest | (y, ys) <- picks xs, rest <- permutations ys]

picks :: [a] -> [(a, [a])]
picks [] = []
picks (x:xs) = (x, xs) : [(y, x:ys) | (y, ys) <- picks xs]

main :: IO ()
main = do
    line <- getLine
    putStr (unlines (sort (permutations line)))
