import Data.List (permutations, sort)
import System.IO (hSetBuffering, stdin, stdout, BufferMode(..))

main :: IO ()
main = do
    hSetBuffering stdin LineBuffering
    hSetBuffering stdout NoBuffering
    input <- getContents
    let perms = permutations $ sort input
    mapM_ putStrLn perms
