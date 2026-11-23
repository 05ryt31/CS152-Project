import Control.Monad.Trans.State.Strict
 
data StackOp = Push Int | Pop | Add | Mul | Dup | Swap | Print
 
parseStackOp :: String -> Maybe StackOp
parseStackOp s =
  case words s of
    ["push", x] -> Just $ Push (read x)
    ["pop"]     -> Just Pop
    ["add"]     -> Just Add
    ["mul"]     -> Just Mul
    ["dup"]     -> Just Dup
    ["swap"]    -> Just Swap
    ["print"]   -> Just Print
    _           -> Nothing
 
stackVM :: [StackOp] -> StateT [Int] [] ()
stackVM ops = mapM_ go ops where
  go (Push x) = modify ((x :) .)
  go Pop      = modify tail
  go Add      = modify (\(a:b:xs) -> (a+b):xs)
  go Mul      = modify (\(a:b:xs) -> (a*b):xs)
  go Dup      = modify (\(x:xs) -> x:x:xs)
  go Swap     = modify (\(a:b:xs) -> b:a:xs)
  go Print    = gets head >>= liftIO . putStrLn . show
 
main :: IO ()
main = do
  ops <- mapMaybe parseStackOp <$> lines <$> getContents
  evalStateT (stackVM ops) []
