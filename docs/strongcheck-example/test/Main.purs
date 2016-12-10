module Test.Main where

import Debug.Trace

import Data.Array
import Data.Foldable (elem)

import Test.StrongCheck
import Test.StrongCheck.Gen

import Wishlist

gifts :: [Gift]
gifts = toGift <$> (1 .. 20)
  where
  toGift :: Number -> Gift
  toGift n = "Gift " ++ show n

instance arbWishlist :: Arbitrary Wishlist where
  arbitrary = do
    n <- chooseInt 0 5
    Wishlist <$> nChooseK n gifts

main = do
  smallCheck Wishlist.verify
  statCheck (1 / 4) $ \(Wishlist wl) -> "Gift 1" `elem` wl
