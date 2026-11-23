import Data.List.Split (splitOn)
 
data StackVM = Push Int | Pop | Add | Mul | Dup | Swap deriving Show
 
parseStackVM :: String -> Either String StackVM
parseStackVM s =
  case splitOn " " s of
    ["push", x] -> Right $ Push $ read x
    ["pop"]     -> Right Pop
    ["add"]     -> Right Add
    ["mul"]     -> Right Mul
    ["dup"]     -> Right Dup
    ["swap"]    -> Right Swap
    _           -> Left "Invalid instruction"
 
evalStackVM :: [Int] -> StackVM -> Either String [Int]
evalStackVM xs vm =
  case vm of
    Push x -> Right $ x : xs
    Pop ->
      if null xs then Left "Stack is empty" else Right $ tail xs
    Add ->
      if length xs < 2 then Left "Not enough elements in stack" else Right $
      let [x, y] = take 2 xs in y + x : drop 2 xs
    Mul ->
      if length xs < 2 then Left "Not enough elements in stack" else Right $
      let [x, y] = take 2 xs in y * x : drop 2 xs
    Dup ->
      if null xs then Left "Stack is empty" else Right $ head xs : xs
    Swap ->
      if length xs < 2 then Left "Not enough elements in stack" else Right $
      let [x, y] = take 2 xs in y : x : drop 2 xs
 
runStackVM :: [String] -> Either String Int
runStackVM ss =
  case foldM evalStackVM [] $ mapM parseStackVM ss of
    Left e -> Left e
    Right [x] -> Right x
    Right _ -> Left "Stack has more than one element at end"
 
main :: IO ()
main = do
  putStrLn "Enter instructions:"
  ss <- getLine
  case runStackVM $ words ss of
    Left e -> putStrLn e
    Right x -> print x
