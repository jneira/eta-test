{-# LANGUAGE TypeFamilies,DataKinds,FlexibleContexts,
             TypeOperators #-}

module Foreign where
import Java.Core

foreign export java "@static eta.example.Foreign.test" jinput
  :: (ja <: Object) => ja -> IO ja
jinput ja = java $ return ja
