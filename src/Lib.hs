{-# LANGUAGE TypeFamilies,DataKinds,FlexibleContexts,
             TypeOperators #-}

module Lib where
import Java
import Control.Exception

foreign export java foo :: IO ()
foo = putStrLn "Hi"

foreign export java "@static eta_test.Lib.getInt" getInt :: Int -> Java a Int
getInt i = return $ i + 2

data JavaData = JavaData @JavaData 
   deriving Class

data EtaData = EtaData @EtaData 
   deriving Class

type instance Inherits EtaData = '[JavaData]

foreign import java unsafe getCounter :: Java EtaData Int

foreign import java unsafe setCounter :: Int -> Java EtaData ()

foreign export java addToCounter :: Int -> Java EtaData Int
addToCounter a = do
  c <- getCounter
  let c' = c + a
  setCounter c'
  return c' 



