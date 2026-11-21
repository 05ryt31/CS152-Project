module Main where

import Data.IORef
import qualified Data.Map.Strict as Map
import Control.Monad
import System.IO

main :: IO ()
main = do
    hSetBuffering stdin NoBuffering
    hSetBuffering stdout NoBuffering
    capacity <- readLn
    n <- readLn
    cache <- newIORef $ Map.empty :: IO (IORef (Map.Map Int Int))
    forM_ [1..n] $ \_ -> do
        line <- getLine
        let [op, k, v] = words line
        case op of
            "get" -> do
                cache' <- readIORef cache
                print $ Map.findWithDefault (-1) (read k) cache'
            _ -> do
                cache' <- readIORef cache
                let newCache = Map.insert (read k) (read v) cache'
                writeIORef cache newCache
