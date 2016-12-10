module Data.Maybe where

import Control.Alt
import Control.Alternative
import Control.Extend
import Control.MonadPlus
import Control.Plus

data Maybe a = Nothing | Just a

maybe :: forall a b. b -> (a -> b) -> Maybe a -> b
maybe b _ Nothing = b
maybe _ f (Just a) = f a

fromMaybe :: forall a. a -> Maybe a -> a
fromMaybe a = maybe a (id :: forall a. a -> a)

isJust :: forall a. Maybe a -> Boolean
isJust = maybe false (const true)

isNothing :: forall a. Maybe a -> Boolean
isNothing = maybe true (const false)

instance functorMaybe :: Functor Maybe where
  (<$>) fn (Just x) = Just (fn x)
  (<$>) _  _        = Nothing

instance applyMaybe :: Apply Maybe where
  (<*>) (Just fn) x = fn <$> x
  (<*>) Nothing   _ = Nothing

instance applicativeMaybe :: Applicative Maybe where
  pure = Just

instance altMaybe :: Alt Maybe where
  (<|>) Nothing r = r
  (<|>) l       _ = l

instance plusMaybe :: Plus Maybe where
  empty = Nothing

instance alternativeMaybe :: Alternative Maybe

instance bindMaybe :: Bind Maybe where
  (>>=) (Just x) k = k x
  (>>=) Nothing  _ = Nothing

instance monadMaybe :: Monad Maybe

instance monadPlusMaybe :: MonadPlus Maybe

instance extendMaybe :: Extend Maybe where
  (<<=) _ Nothing  = Nothing
  (<<=) f x        = Just $ f x

instance semigroupMaybe :: (Semigroup a) => Semigroup (Maybe a) where
  (<>) Nothing  x        = x
  (<>) x        Nothing  = x
  (<>) (Just x) (Just y) = Just (x <> y)

instance showMaybe :: (Show a) => Show (Maybe a) where
  show (Just x) = "Just (" ++ show x ++ ")"
  show Nothing  = "Nothing"

instance eqMaybe :: (Eq a) => Eq (Maybe a) where
  (==) Nothing   Nothing   = true
  (==) (Just a1) (Just a2) = a1 == a2
  (==) _         _         = false
  (/=) a b = not (a == b)

instance ordMaybe :: (Ord a) => Ord (Maybe a) where
  compare (Just x) (Just y) = compare x y
  compare Nothing  Nothing  = EQ
  compare Nothing  _        = LT
  compare _        Nothing  = GT
