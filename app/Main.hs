{-# LANGUAGE MagicHash,TypeFamilies,DataKinds,FlexibleContexts #-}
module Main where
import qualified Data.ByteString              as B
import Network.Wai
import GHC.Base
import Data.Word (Word8)
import Foreign.Ptr (Ptr,nullPtr)
import Foreign.ForeignPtr (ForeignPtr,newForeignPtr_,withForeignPtr)
import qualified Data.ByteString.Internal as BSInt
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
  
   
