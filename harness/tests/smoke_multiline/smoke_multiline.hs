main :: IO ()
main = interact (unlines . reverse . lines)
