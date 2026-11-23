perms [] = [[]]
perms xs = [x : ps | x <- xs, ps <- perms $ filter (/= x) xs]
 
main = print $ perms "abc"
