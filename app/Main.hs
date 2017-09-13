{-# LANGUAGE MagicHash,TypeFamilies,DataKinds,
    FlexibleContexts,OverloadedStrings #-}
module Main where
import Data.Text
import Data.Text.Encoding
import Data.Text.Encoding.Error


main = do
  putStrLn "\xf1"
  putStrLn "ñ"
  putStrLn "\xc3\xb1"
  print $ decodeUtf8With lenientDecode "ñ"
  print $ decodeUtf8With lenientDecode "añ"
  print $ decodeUtf8With strictDecode "ñ"

  
