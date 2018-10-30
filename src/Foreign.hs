{-# LANGUAGE TypeFamilies,DataKinds,FlexibleContexts,
             TypeOperators #-}

module Foreign where
import Java.Core

foreign import java "@static eta.example.Counter.testImport" jtestImport
 :: (ji <: Object) => JString -> ji

foreign export java "@static eta.example.Foreign.testExport" jtestExport
  :: (je <: Object) => JString -> je -> IO je
jtestExport str ja = java $ return ja
