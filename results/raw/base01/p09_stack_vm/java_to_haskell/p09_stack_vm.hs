module Main where

import Data.List.Split (splitOn)
import Control.Monad (when)

main :: IO ()
main = do
    input <- getContents
    let lines' = lines input
    let n = read $ head lines'
    let commands = tail lines'
    processCommands n commands

processCommands :: Int -> [String] -> IO ()
processCommands _ [] = return ()
processCommands n commands = do
    let (cmd:rest) = commands
    case cmd of
        "push" -> push rest
        "pop" -> pop
        "add" -> add
        "mul" -> mul
        "dup" -> dup
        "swap" -> swap
        "print" -> printTop
        _ -> putStrLn "error"
    processCommands n rest

push :: [String] -> IO ()
push (x:xs) = modifyStack (\s -> x : s)
push _ = putStrLn "error"

pop :: IO ()
pop = modifyStack (\s -> case s of
    [] -> error "empty stack"
    (_:ss) -> ss)

add :: IO ()
add = binaryOp (+)

mul :: IO ()
mul = binaryOp (*)

dup :: IO ()
dup = modifyStack (\s -> case s of
    [] -> error "empty stack"
    (x:xs) -> x : x : xs)

swap :: IO ()
swap = modifyStack (\s -> case s of
    [] -> error "empty stack"
    [_] -> error "not enough elements on stack"
    (a:b:xs) -> b : a : xs)

printTop :: IO ()
printTop = modifyStack (\s -> case s of
    [] -> error "empty stack"
    (x:_) -> putStrLn x)

binaryOp :: (Int -> Int -> Int) -> IO ()
binaryOp op = modifyStack (\s -> case s of
    [] -> error "empty stack"
    [_] -> error "not enough elements on stack"
    (b:a:xs) -> op a b : xs)

modifyStack :: ([String] -> [String]) -> IO ()
modifyStack f = do
    stack <- readIORef stackRef
    let newStack = f stack
    writeIORef stackRef newStack

stackRef :: IORef [String]
stackRef = unsafePerformIO $ newIORef []

{-# NOINLINE stackRef #-}
