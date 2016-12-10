module Main where

import Control.Monad.Eff

import Rx.JQuery
import Rx.Observable

import Control.Monad.JQuery

main = do
  red <- select "#red"
  green <- select "#green"
  output <- select "#output"
  
  redOver <- "mouseover" `onAsObservable` red
  redMove <- "mousemove" `onAsObservable` red
  redOut  <- "mouseout"  `onAsObservable` red
  
  greenOver <- "mouseover" `onAsObservable` green
  greenMove <- "mousemove" `onAsObservable` green
  greenOut  <- "mouseout" `onAsObservable` green

  redOver `subscribe` \_ -> void $ "red mouseover\n" `setText` output
  redMove `subscribe` \_ -> void $ "red mousemove\n" `setText` output
  redOut  `subscribe` \_ -> void $ "red mouseout\n"  `setText` output

  greenOver `subscribe` \_ -> void $ "green mouseover\n" `setText` output
  greenMove `subscribe` \_ -> void $ "green mousemove\n" `setText` output
  greenOut  `subscribe` \_ -> void $ "green mouseout\n"  `setText` output

  let gestureLeft = do redOver
                       redOut
                       greenOver
                       greenOut
  let gestureRight = do greenOver
                        greenOut
                        redOver
                        redOut

  gestureLeft  `subscribe` \_ -> void $ "Swipe left\n"  `setText` output
  gestureRight `subscribe` \_ -> void $ "Swipe right\n" `setText` output

  return unit

