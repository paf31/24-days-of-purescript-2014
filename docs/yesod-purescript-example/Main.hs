{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE OverloadedStrings #-}

module Main where

import Data.Default

import qualified Yesod.Core as Y
import qualified Yesod.PureScript as Y

data Greeting = Greeting { getPureScriptSite :: Y.PureScriptSite }

Y.mkYesod "Greeting" [Y.parseRoutesNoCheck|
/     Home 
/purs PureScript Y.PureScriptSite getPureScriptSite
|]

instance Y.Yesod Greeting

instance Y.YesodPureScript Greeting

handleHome :: Handler Y.Html
handleHome = do
  Y.defaultLayout $ do
    Y.setTitle "Merry Christmas from PureScript!"
    Y.addScript $ PureScript $ Y.getPureScriptRoute ["Main"]

main = do
  purs <- Y.createYesodPureScriptSite def
  Y.warp 8080 $ Greeting purs
