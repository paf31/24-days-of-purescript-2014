module Main where

import Control.Monad.Eff

import React
import React.DOM

initialState = { name: "" }

ui = mkUI spec { getInitialState = pure initialState } $ 
       view <$> readState
  where
  view st = 
    div [] [ p [] [ text "Your name: " 
                  , input [ onChange updateName ] []
                  ]
           , case st.name of
               "" -> p [] [ text "Please enter your name." ]
               name -> p [] [ text "Merry Christmas, "
                            , text name
                            , text "!" 
                            ]
           ]

  updateName :: Event -> EventHandlerContext _ _ _ _ _
  updateName e = writeState { name: getValue e } 

foreign import getValue 
  "function getValue (e) {\
  \  return e.target.value;\
  \}" :: Event -> String

main = 
  let 
    component = div [] [ ui {} ] 
  in renderToBody component 

