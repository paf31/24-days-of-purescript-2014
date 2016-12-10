module Main where

import Control.Monad.Eff

import DOM
import Control.Timer

import Signal
import Signal.DOM
import Signal.Time

foreign import render
  "function render(pos) {\
  \  return function() {\
  \    var rudolf = document.getElementById('rudolf');\
  \    rudolf.style.left = pos.x + 'px';\
  \    rudolf.style.top  = pos.y + 'px';\
  \  };\
  \}" :: forall eff. CoordinatePair -> Eff (dom :: DOM | eff) Unit

type Dimensions = { w :: Number, h :: Number }

foreign import dimensions
  "function dimensions() {\
  \  return { w: document.body.offsetWidth\
  \         , h: document.body.offsetHeight\
  \         };\
  \};" :: forall eff. Eff (dom :: DOM | eff) Dimensions

main = do
  mouse <- mousePos
  dims  <- dimensions
  runSignal (render <~ rudolf mouse dims)
  where
  rudolf :: Signal CoordinatePair -> Dimensions -> Signal CoordinatePair 
  rudolf mouse dims = foldp update { x: dims.w / 2, y: dims.h / 2 } (sampleOn (every (20 * millisecond)) mouse)
    where
      update :: CoordinatePair -> CoordinatePair -> CoordinatePair
      update pos old = 
        let dx  = pos.x - old.x
            dy  = pos.y - old.y
            d   = Math.sqrt (dx * dx + dy * dy)
            d'  = if d > 100 then d else 20
            v   = 2000 / d'
            vx  = (old.x - pos.x) / d'
            vy  = (old.y - pos.y) / d'
            nx  = clamp (old.x + v * vx) dims.w
            ny  = clamp (old.y + v * vy) dims.h
            new = { x: nx, y: ny }
            opx = (old.x + dims.w / 2) % dims.w
            opy = (old.y + dims.h / 2) % dims.h
            op  = { x: opx, y: opy }
            
        in if d <= 100 then op else new
      
      clamp x max | x < 0 = 0
                  | x > max = max
                  | otherwise = x

