{-# LANGUAGE TypeFamilies,DataKinds,FlexibleContexts,
             TypeOperators, ScopedTypeVariables #-}

module Foreign where
import Data.Word
import Java.Core
import Java.Wrappers
import Java.Array
import Java.Collections

foreign import java "@static eta.example.Counter.testImport" jtestImport
 :: (ji <: Object) => JString -> ji

foreign export java "@static eta.example.Foreign.testExport" jtestExport
  :: (je <: Object) => JString -> je -> IO je
jtestExport str je = java $ return je

foreign export java "@static eta.example.Foreign.testExportSuper" jtestExportSuper
  :: (je <: Object) => JString -> je -> IO Object
  
jtestExportSuper :: (je <: Object) => JString -> je -> IO Object
jtestExportSuper str je = java $ return o
  where o :: Object = superCast je
{-# NOINLINE jtestExportSuper #-}

foreign export java "@static eta.example.Foreign.testExportSuperTwo" jtestExportSuperTwo
  :: (x <: JNumber, y <: JNumber) => x -> y -> IO JInteger

foreign import java unsafe intValue :: (b <: JNumber) => b -> Int

jtestExportSuperTwo :: (x <: JNumber, y <: JNumber) => x -> y -> IO JInteger
jtestExportSuperTwo x y = java $ return res
  where res :: JInteger = toJava ( intValue x + intValue y )
{-# NOINLINE jtestExportSuperTwo #-}

foreign export java "@static eta.example.Foreign.testJByteArray"
  jtestJByteArray :: JByteArray
jtestJByteArray = toJava ([1,2] :: [Word8])

foreign export java "@static eta.example.Foreign.testJByteArrayId"
  jtestJByteArrayId :: JByteArray -> JByteArray
jtestJByteArrayId a = a

jtestJByteArrayList :: List JInteger -> JByteArray
jtestJByteArrayList _ = unsafePerformJava (anew 0)

