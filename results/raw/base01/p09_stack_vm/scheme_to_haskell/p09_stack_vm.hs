import Data.Char (intToDigit)
import Data.List (splitAt)
import System.IO

main :: IO ()
main = do
    n <- readLn
    interact $ unlines . processCommands . lines . head . splitAt n . lines

processCommands :: [String] -> [String]
processCommands commands = reverse $ foldl processCommand [] commands

processCommand :: [Int] -> String -> [Int]
processCommand stack command = case words command of
    ["push", num] -> push (read num) stack
    ["pop"] -> pop stack
    ["add"] -> add stack
    ["mul"] -> mul stack
    ["dup"] -> dup stack
    ["swap"] -> swap stack
    _ -> error "Invalid command"

push :: Int -> [Int] -> [Int]
push x stack = x : stack

pop :: [Int] -> [Int]
pop [] = []
pop (x:xs) = xs

add :: [Int] -> [Int]
add [] = []
add [_] = []
add (x:y:xs) = (x + y) : xs

mul :: [Int] -> [Int]
mul [] = []
mul [_] = []
mul (x:y:xs) = (x * y) : xs

dup :: [Int] -> [Int]
dup [] = []
dup (x:xs) = x : x : xs

swap :: [Int] -> [Int]
swap [] = []
swap [_] = []
swap (x:y:xs) = y : x : xs
