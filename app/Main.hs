{-# LANGUAGE MagicHash,TypeFamilies,DataKinds,
    FlexibleContexts,OverloadedStrings, ScopedTypeVariables #-}
module Main where
import Java
import Java.Exception
import qualified System.IO.Error as SysIOErr
import Data.Proxy
import Data.Typeable
import qualified Control.Exception as EX 

foreign import java "@new" newFileNotFoundException ::  String -> FileNotFoundException
foreign import java "@new" newException ::  String -> JException

main = do
  let ioEx = newFileNotFoundException "io ex"
      ex   = newException "ex"
  r <- SysIOErr.tryIOError (EX.throwIO ioEx)
  case r of
    Right() -> return ()
    Left err -> putStrLn $ EX.displayException err
  (r' :: Either JException ()) <- EX.try (EX.throwIO ex)
  case r' of
    Right() -> return ()
    Left err -> putStrLn $ EX.displayException err
  (r' :: Either EX.IOException ()) <- EX.try (EX.throwIO ioEx)
  case r' of
    Right() -> return ()
    Left err -> putStrLn $ EX.displayException err
--  r <- SysIOErr.tryIOError (EX.throwIO ex)
--  case r of
--    Right() -> return ()
--    Left err -> putStrLn $ EX.displayException err
  (r' :: Either JException ()) <- EX.try (EX.throwIO ioEx)
  case r' of
    Right() -> return ()
    Left err -> putStrLn $ EX.displayException err
  
