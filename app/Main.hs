{-# LANGUAGE MagicHash,TypeFamilies,DataKinds,
    FlexibleContexts,OverloadedStrings, ScopedTypeVariables #-}
module Main where
import Java
import Java.Exception
import qualified System.IO.Error as SysIOErr
import qualified Control.Exception as EX 


foreign import java "@new" newFileNotFoundException ::  String -> FileNotFoundException
foreign import java "@new" newException ::  String -> JException

mkIOError type' msg = SysIOErr.ioeSetErrorString
                      (SysIOErr.mkIOError type' "" Nothing Nothing) msg

main = do
  let ioEx = newFileNotFoundException "io ex"
      ex   = newException "ex"
      ioErr = mkIOError SysIOErr.doesNotExistErrorType "ioerr"
  SysIOErr.catchIOError (EX.throwIO ioErr) $ putStrLn . show
  catchJavaIOError (EX.throwIO ioErr) $ putStrLn . show

  EX.catch (EX.throwIO ioEx) $ \ (e :: JException) -> putStrLn $ show  e
  EX.catch (EX.throwIO ex) $ \ (e :: JException) -> putStrLn $ show e

  catchJavaIOError (EX.throw ioEx) $ putStrLn . show
  catchJavaIOError (readFile "x" >> return ()) $ putStrLn . show
