{-# LANGUAGE MagicHash,TypeFamilies,DataKinds,
    FlexibleContexts,OverloadedStrings #-}
module Main where
import GHC.Base
import Java

foreign import java unsafe "@static Utils.testEmptyBuffer"
  testEmptyBuffer :: IO ()

main = testEmptyBuffer
  

