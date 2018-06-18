{-# LANGUAGE TypeFamilies,DataKinds,FlexibleContexts,
             TypeOperators #-}

module Lib where
import Java
import Control.Exception
import Data.Either

-- ffi export using IO ()

foreign export java "@static eta_test.Lib.exportedFoo" foo :: IO ()
foo = putStrLn "Hi"

-- ffi export using IO a

foreign export java "@static eta_test.Lib.exportedBar" bar :: IO Int
bar = return 0

-- ffi export static standard

foreign export java "@static eta_test.Lib.getInt" getInt :: Int -> Java a Int
getInt i = return $ i + 2


-- An ffi export instance method of the module! It generates a instance method for eta_test.Lib class
-- However, this can't be called from java cause the generated class has no constructors

foreign export java instanceMethod :: Int -> Java a Int
instanceMethod i = return $ i + 2


-- ffi export instance method for subclass

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

-- ffi export static method with lambdas (Consumer)  as parameters

newtype ParseError = ParseError String 

parse :: String -> Either ParseError String
parse [] = Left $ ParseError "Empty string"
parse str = Right str

data Consumer t = Consumer (@java.util.function.Consumer t)
  deriving Class

foreign import java unsafe "@interface"
  accept :: ( t <: Object ) => t -> Java (Consumer t) ()

foreign export java "@static eta_test.Lib.jparse" jparse :: JString -> Consumer JString -> Consumer JString -> Java a ()

jparse str err ok = case parse $ fromJString str of
  Left (ParseError errStr) -> err <.> (accept $ toJString errStr)
  Right str -> ok <.> (accept $ toJString str)



