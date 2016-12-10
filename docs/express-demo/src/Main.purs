module Main where

import Data.Maybe

import Node.Express.Types
import Node.Express.App
import Node.Express.Handler

handler :: Handler
handler = do
  Just name <- getParam "name"
  sendJson { greeting: "Merry Christmas, " <> name <> "!" }

app :: App
app = get "/greet/:name" handler

main = listen app 8080 \_ -> return unit
