module Lib where
import Java

foreign import java unsafe "@static Utils.testEmptyBuffer" testEmptyBuffer :: IO()

foreign export java
 foo :: IO ()
foo = putStrLn "Hi"

