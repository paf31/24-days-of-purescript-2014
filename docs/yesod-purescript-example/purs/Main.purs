module Main where

import Control.Monad.Eff

foreign import data Alert :: !

foreign import alert 
  "function alert(s) {\
  \  return function() {\
  \    window.alert(s);\
  \  };\
  \}" :: forall eff. String -> Eff (alert :: Alert | eff) Unit

main = alert "Merry Christmas!"
