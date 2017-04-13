{-# LANGUAGE MagicHash,TypeFamilies,DataKinds,FlexibleContexts #-}
module Main where
import Network.Wai
import Java

main = print $ [show $ requestMethod r, show $ httpVersion r,
                show $ rawPathInfo r, show $ rawQueryString r]
  where r = defaultRequest
