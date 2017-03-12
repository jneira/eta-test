{-# LANGUAGE MagicHash,TypeFamilies,DataKinds,FlexibleContexts #-}
module Main where
import Java

data {-# CLASS "network.wai.servlet.WaiServlet extends javax.servlet.GenericServlet" #-}
  WaiServlet = WaiServlet (Object# WaiServlet) deriving Class
data {-# CLASS "javax.servlet.ServletResponse" #-} ServletResponse =
  ServletResponse (Object# ServletResponse) deriving Class
data {-# CLASS "javax.servlet.ServletRequest" #-} ServletRequest =
  ServletRequest (Object# ServletRequest) deriving Class


service :: ServletRequest -> ServletResponse -> Java WaiServlet () 
service = undefined

foreign export java service :: ServletRequest -> ServletResponse -> Java WaiServlet ()

main = undefined
