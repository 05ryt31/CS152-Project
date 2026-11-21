import System.IO

main :: IO ()
main = do
    contents <- getContents
    let lines = lines contents
        n = read $ head lines
        (_, _, result) = foldl processCommand ([], [], []) $ zip [""] (tail lines)
    putStr $ unlines result

processCommand :: ([Int], [String], [String]) -> (String, String) -> ([Int], [String], [String])
processCommand (stack, errors, results) (op, arg) = case op of
    "push" -> (stack', errors, results)
      where
        stack' = read arg : stack
    "pop" -> (stack', errorOrResult, results)
      where
        stack' = tail stack
        errorOrResult = if null stack then "error" else ""
    "add" -> (stack', errorOrResult, results)
      | length stack < 2 = (stack, "error", results)
      | otherwise = (a + b : init stack, "", results)
      where
        (b:a:rest) = stack
    "mul" -> (stack', errorOrResult, results)
      | length stack < 2 = (stack, "error", results)
      | otherwise = (a * b : init stack, "", results)
      where
        (b:a:rest) = stack
    "dup" -> (stack', errorOrResult, results)
      | null stack = (stack, "error", results)
      | otherwise = (top : stack, "", results)
      where
        top = last stack
    "swap" -> (stack', errorOrResult, results)
      | length stack < 2 = (stack, "error", results)
      | otherwise = (swappedStack, "", results)
      where
        (x:y:xs) = stack
        swappedStack = y : x : xs
    _ -> (stack, errorOrResult, results)
      where
        errorOrResult = if null stack then "error" else show (last stack)
