module Main where

import Control.Monad.Eff

import Graphics.Canvas (getCanvasElementById, getContext2D)
import Graphics.Canvas.Free

yellow = "#FFFF00"

red = "#FF0000"

triangle = do
  moveTo 0 (-100)
  lineTo 75 100
  lineTo (-75) 100

at x y gfx = do
  save
  translate x y
  gfx
  restore

bauble size = do
  beginPath
  arc { x: 0, y: 0, r: size, start: 0, end: Math.pi * 2 }
  fill

main = do
  canvas <- getCanvasElementById "canvas"
  context <- getContext2D canvas

  runGraphics context $ do
    
    setFillStyle "#EEFFEE"
    rect { x: 0, y: 0, w: 400, h: 600 }
    fill

    setShadowColor "#BBDDBB"
    setShadowBlur 5
    
    at 200 175 do
      setFillStyle "#CCDDCC"
      beginPath
      triangle
      at 0 50 triangle
      at 0 100 triangle
      closePath
      rect { x: (-40), y: 200, w: 80, h: 50 }
      fill
    
      setFillStyle "#EEFFEE"
      at (-10) (-10) $ bauble 10
      at (-20)   50  $ bauble 10
      at    0   100  $ bauble 10
      at (-20)  140  $ bauble 10
      at   20   190  $ bauble 7
      at   30    50  $ bauble 7
      at (-50)   75  $ bauble 7
      at (-40)  180  $ bauble 7
      at   50   125  $ bauble 7
      at   40   175  $ bauble 7
 
    setFillStyle "#008000"
    setFont "48px Sans-Serif"
    fillText "Merry Christmas" 25 50 
    fillText "From PureScript!" 20 480
