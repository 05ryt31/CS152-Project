perms [] = [[]]
perms xs = [x : ys | x <- xs, ys <- perms $ filter (/= x) xs]
 
main = print $ perms "abc"
