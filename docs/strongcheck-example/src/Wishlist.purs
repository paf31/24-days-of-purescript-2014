module Wishlist where

import Data.Array (length, nub)

type Gift = String

newtype Wishlist = Wishlist [Gift]

verify :: Wishlist -> Boolean
verify (Wishlist wl) 
  | length wl > 5 = false
  | length (nub wl) /= length wl = false
  | otherwise = true
