module Main where

import Data.Tuple
import Data.Maybe
import Data.Array (reverse, take, (..))

import DOM

import Control.Monad.Eff

import VirtualDOM.VTree
import qualified VirtualDOM.VTree.Typed as VTT

import FRP.Rabbit (runRabbit)
import FRP.Rabbit.Handler (createEventHandler)
import FRP.Rabbit.Signal (Signal(..), stateful)

gifts :: [String]
gifts = [ "partridge in a pear tree"
        , "turtle doves"
        , "french hens"
        , "calling birds"
        , "golden rings"
        , "geese a-laying"
        , "swans a-swimming"
        , "maids a-milking"
        , "ladies dancing"
        , "lords a-leaping"
        , "pipers piping"
        , "drummers drumming"
        ]

th :: Number -> String
th 1 = "st"
th 2 = "nd"
th 3 = "rd"
th _ = "th"

type Model = [Tuple Number String]

model :: Number -> Model
model n = reverse (take n (zip (1..12) gifts))

el :: String -> [VTree] -> VTree
el name kids = vnode name { } kids

view :: VTT.Handler _ -> Number -> VTree
view nextDay n = el "div"
  [ el "h1" [ vtext "The twelve days of Christmas" ]
  , el "p"  [ vtext "On the "
            , vtext $ show n
            , vtext $ th n
            , vtext " day of Christmas, my true love gave to me:"
            ]
  , el "ul" $ day <$> model n
  , VTT.vnode "button" [ VTT.handler "onclick" nextDay ] [ vtext "> Next" ] Nothing Nothing
  ]
  where
  day (Tuple count gift) = el "li"
    [ vtext $ show count
    , vtext " "
    , vtext gift
    ]
    
foreign import appendToBody
  "function appendToBody(node) {\
  \  return function() {\
  \    document.body.appendChild(node);\
  \  };\
  \}" :: forall eff. Node -> Eff (dom :: DOM | eff) Unit

main = do
  handler <- createEventHandler
  let day = stateful (\_ day -> (day + 1) % 12) 0 handler.event <> pure 0
  runRabbit (view handler.handler <<< ((+) 1) <$> day) appendToBody
