{-# LANGUAGE MagicHash,TypeFamilies,DataKinds,
    FlexibleContexts,OverloadedStrings #-}
module Main where
import Network.Wai
import Network.HTTP.Types as H
import Network.Socket
import Data.Word (Word8)
import Data.Text as T
import Data.Text.Encoding
import Data.Text.Encoding.Error
import qualified Data.ByteString              as B
import qualified Data.ByteString.Internal as BSInt
import Foreign.Ptr (Ptr,nullPtr)
import Foreign.ForeignPtr (ForeignPtr,newForeignPtr_,withForeignPtr)
import GHC.Base
import Java

foreign import java unsafe "@static Utils.trace"
   trace :: Ptr Word8 -> Int -> Int -> IO ()

main = do
  putStrLn $ "nullPtr: " ++ show nullPtr
  let (fptr,offset,length) = BSInt.toForeignPtr B.empty
  withForeignPtr fptr $ \ ptr -> do
    trace ptr offset length
    putStrLn $ "ptr: " ++ show ptr
    putStrLn $ "ptr == nullPtr " ++ (show $ nullPtr == ptr)
  putStrLn $ "ByteString.empty: " ++  show B.empty
  putStrLn $ "Wai request: " ++ show defaultRequest
  print $ SockAddrInet6 0 0 (tupleToHostAddress6 (0,0,0,0,0,0,0,0)) 0 
  print $ H.decodePathSegments "/my/path"
  print $ H.parseQuery "a=1&b=2"

