module Main where

import Data.Options
import Data.Foldable (intercalate)

import Control.Monad.Eff

import Debug.Trace

foreign import data JQueryAJAXOptions :: *

foreign import unsafeToOption
  "function unsafeToOption(s) {\
  \  return s;\
  \}" :: forall a. String -> Option JQueryAJAXOptions a

async :: Option JQueryAJAXOptions Boolean
async = unsafeToOption "async"

contentType :: Option JQueryAJAXOptions String
contentType = unsafeToOption "contentType"

timeout :: Option JQueryAJAXOptions Number
timeout = unsafeToOption "timeout"

url :: Option JQueryAJAXOptions String
url = unsafeToOption "url"

data DataType = XML | HTML | Script | JSON | JSONP

dataTypeToString :: DataType -> String
dataTypeToString XML    = "xml"
dataTypeToString HTML   = "html"
dataTypeToString Script = "script"
dataTypeToString JSON   = "json"
dataTypeToString JSONP  = "jsonp"

data DataTypes = DataTypes [DataType]

instance optionDataTypes :: IsOption DataTypes where
  (:=) k (DataTypes ts) = (optionFn k) := intercalate " " (dataTypeToString <$> ts)

dataType :: Option JQueryAJAXOptions DataTypes
dataType = unsafeToOption "dataType"

opts :: Options JQueryAJAXOptions
opts = async       := true
    <> contentType := "application/json"
    <> timeout     := 10000
    <> url         := "/"
    <> dataType    := DataTypes [XML, JSON]

main = let optsValue = options opts
       in log optsValue

foreign import log
  "function log(a){\
  \  return function() {\
  \    console.log(a);\
  \  };\
  \}" :: forall a eff. a -> Eff (trace :: Trace | eff) Unit
