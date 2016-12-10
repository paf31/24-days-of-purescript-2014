module Main where

import Debug.Trace

import Data.Tuple (Tuple(..), zip)
import Data.Array ((..), take, reverse)
import Data.Foldable (for_)

import DOM

import Control.Monad.Eff

import Text.Smolder.HTML (h1, p, ul, li)
import Text.Smolder.HTML.Attributes (name, content) 
import Text.Smolder.Markup (Markup(), (!), text)
import Text.Smolder.Renderer.String (render)

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

day :: Number -> Model
day n = reverse (take n (zip (1..12) gifts))

view :: Markup
view = do
  h1 $ text "The twelve days of Christmas"
  for_ (1..12) $ \n -> do
    p $ do
      text "On the "
      text $ show n
      text $ th n
      text " day of Christmas, my true love gave to me:"
    ul $ do
      for_ (day n) $ \(Tuple count gift) -> li do
        text $ show count
        text " "
        text gift

foreign import asBody """
  function asBody(html) {
    return function() {
      onload = function() {
        document.body.innerHTML = html;
      };
    };
  }""" :: forall eff. String -> Eff (dom :: DOM | eff) Unit

main = asBody $ render view
