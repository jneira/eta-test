module Lib where
import Java

foreign import java unsafe "@static Utils.testEmptyBuffer" testEmptyBuffer :: IO()

foreign export java foo :: IO ()
foo = putStrLn "Hi"

foreign export java "@static eta_test.Lib.getInt" getInt :: Int -> Java a Int
getInt i = return $ i + 2


