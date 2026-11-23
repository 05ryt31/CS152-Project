import Data.List.Split (splitOn)
 
data Instruction = Push Int | Pop | Add | Mul | Dup | Swap | Print deriving Show
 
parseInstruction :: String -> Instruction
parseInstruction s =
  case words s of
    "push" : x : [] -> Push $ read x
    "pop" : [] -> Pop
    "add" : [] -> Add
    "mul" : [] -> Mul
    "dup" : [] -> Dup
    "swap" : [] -> Swap
    "print" : [] -> Print
    _ -> error "Invalid instruction"
 
type StackVMState = ([Int], [Instruction])
 
step :: StackVMState -> StackVMState
step ([], _) = error "Empty stack"
step ((x:xs), (Push y : is)) = (y:x:xs, is)
step ((x:xs), (Pop : is)) = (xs, is)
step ((x:y:xs), (Add : is)) = (x+y:xs, is)
step ((x:y:xs), (Mul : is)) = (x*y:xs, is)
step ((x:xs), (Dup : is)) = (x:x:xs, is)
step ((x:y:xs), (Swap : is)) = (y:x:xs, is)
step ((x:xs), (Print : is)) = (x:xs, is)
step (_, _) = error "Invalid state"
 
run :: StackVMState -> StackVMState
run state@(stack, instructions)
  | null instructions = state
  | otherwise = run $ step state
 
main :: IO ()
main = do
  putStrLn "Enter your program:"
  program <- getLine
  putStrLn "Enter your inputs:"
  inputs <- getLine
  let vmState = ([], map parseInstruction $ splitOn "\n" program)
      finalState = run vmState
  print finalState
