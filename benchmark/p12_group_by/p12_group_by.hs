import Data.Map.Strict (Map)
import qualified Data.Map.Strict as Map
import Control.Monad (replicateM)

processRows :: [String] -> [String]
processRows rows = map (uncurry showGroup) (Map.toAscList grouped)
    where
        grouped = foldl add Map.empty rows

        add :: (Map.Map String (Int, Int)) -> String -> (Map.Map String (Int, Int))
        add groups line = case words line of
            [key, value] ->
                let v = read value :: Int
                in Map.insertWith (\(v', c') (s, c) -> (s + v', c + c')) key (v, 1) groups
            _ -> groups

        showGroup :: String -> (Int, Int) -> String
        showGroup key (s, c) = unwords [key, show s, show c]

main :: IO ()
main = do
    n <- readLn
    rows <- replicateM n getLine
    mapM_ putStrLn (processRows rows)
