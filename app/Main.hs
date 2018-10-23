{-# LANGUAGE MagicHash,TypeFamilies,DataKinds,
    FlexibleContexts,OverloadedStrings, ScopedTypeVariables #-}
module Main where
import Lib
import Java

main = do
  i <- java $ createAndUseEtaCounter
  java $ newJavaCounter >- setNumCounters 10
  setNumCounters' 11
  return $ setNumCounters'' 12 -- No effect
  i' <- java $ getNumCounters
  putStrLn $ show i'
  putStrLn $ "The value is " ++ show i  
