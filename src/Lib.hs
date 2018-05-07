module Lib where

foreign export java
 foo :: IO ()
foo = putStrLn "Hi"

