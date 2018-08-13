{-# LANGUAGE MagicHash,TypeFamilies,DataKinds,
    FlexibleContexts,OverloadedStrings, ScopedTypeVariables #-}
module Main where
import Lib
import Java

main = do
  i <- java $ createAndUseEtaCounter
  putStrLn $ "The value is " ++ show i  
