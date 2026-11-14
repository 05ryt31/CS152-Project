import Control.Monad (replicateM)
import qualified Data.IntMap.Strict as IM
import qualified Data.IntSet as IS
import Data.Sequence (Seq (..), (|>))
import qualified Data.Sequence as Seq

readNums :: String -> [Int]
readNums s = map read (words s)

main :: IO ()
main = do
    [n, m] <- readNums <$> getLine
    edges <- replicateM m (readNums <$> getLine)
    [s, t] <- readNums <$> getLine

    let graph = foldl (\g [u, v] -> IM.insertWith (++) u [v] (IM.insertWith (++) v [u] g)) IM.empty edges
        bfs :: Seq (Int, Int) -> IS.IntSet -> Int
        bfs Empty _ = -1
        bfs ((node, d) :<| queue) seen
            | node == t = d
            | otherwise =
                let neighbors = IM.findWithDefault [] node graph
                    next = filter (`IS.notMember` seen) neighbors
                    seen' = foldl' (flip IS.insert) seen next
                    queue' = foldl' (\q v -> q |> (v, d + 1)) queue next
                in bfs queue' seen'

        result = bfs (Seq.singleton (s, 0)) (IS.singleton s)

    putStrLn (show result)
