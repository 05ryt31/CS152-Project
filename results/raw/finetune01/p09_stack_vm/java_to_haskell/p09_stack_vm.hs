import Control.Monad.Trans.State.Strict
 
data StackOp = Push Int | Pop | Add | Mul | Dup | Swap | Print
 
parseOp :: String -> Maybe StackOp
parseOp "push" = Just Push
parseOp "pop" = Just Pop
parseOp "add" = Just Add
parseOp "mul" = Just Mul
parseOp "dup" = Just Dup
parseOp "swap" = Just Swap
parseOp "print" = Just Print
parseOp _ = Nothing
 
parseOps :: [String] -> Maybe [StackOp]
parseOps = traverse parseOp
 
evalOp :: StateT [Int] [] ()
evalOp = do
  s <- get
  case s of
    [] -> return ()
    x:_ -> put $ tail s >>=
      \case
        [] -> []
        y:_ -> case parseOps ["push", show x, "push", show y] of
          Just ops -> mapM_ evalOp ops
          Nothing -> error "Invalid operation"
 
evalStackVM :: [String] -> Maybe [Int]
evalStackVM = execStateT $ mapM_ evalOp . parseOps
 
main :: IO ()
main = print <$> evalStackVM ["push", "5", "push", "3", "add", "print"]
