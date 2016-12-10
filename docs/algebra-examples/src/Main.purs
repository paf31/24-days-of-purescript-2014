module Main where

import Data.Array hiding (head)
import Data.Array.Unsafe (head)
import Data.Function (on)

import qualified Data.Monoid as Monoid
import qualified Data.Semigroup as Monoid

data Outcome p a = Outcome p a

instance showOutcome :: (Show p, Show a) => Show (Outcome p a) where
  show (Outcome p x) = "(Outcome " ++ show p ++ " " ++ show x ++ ")"

data Prob p a = Prob [Outcome p a]

runProb :: forall p a. Prob p a -> [Outcome p a]
runProb (Prob xs) = xs

instance functorOutcome :: Functor (Outcome p) where
  (<$>) f (Outcome p x) = Outcome p (f x)

instance functorProb :: Functor (Prob p) where
  (<$>) f (Prob xs) = Prob ((<$>) f <$> xs)

instance applyProb :: (Monoid.MultSemigroup p, Monoid.MultMonoid p) => Apply (Prob p) where
  (<*>) = ap

instance applicativeProb :: (Monoid.MultSemigroup p, Monoid.MultMonoid p) => Applicative (Prob p) where
  pure x = Prob [Outcome Monoid.one x]

instance bindProb :: (Monoid.MultSemigroup p, Monoid.MultMonoid p) => Bind (Prob p) where
  (>>=) (Prob xs) f = Prob do
    Outcome p x <- xs
    Outcome q y <- runProb (f x)
    return $ Outcome (p Monoid.* q) y

instance monadProb :: (Monoid.MultSemigroup p, Monoid.MultMonoid p) => Monad (Prob p)

normalize :: forall p a. (Ord a, Monoid.AddMonoid p) => Prob p a -> Prob p a
normalize (Prob xs) = Prob (map combine $ groupBy ((==) `on` value) $ sortBy (compare `on` value) xs)
  where
  value :: Outcome _ _ -> _
  value (Outcome _ x) = x

  prob :: Outcome _ _ -> _
  prob (Outcome p _) = p

  sum :: [_] -> _
  sum [] = Monoid.zero
  sum (n : ns) = sum ns Monoid.+ n

  combine :: [Outcome _ _] -> Outcome _ _
  combine xs = 
    let p = sum $ map prob xs
        x = value $ head xs
    in Outcome p x

die :: Prob Number Number
die = Prob
  [ Outcome (1 / 6) 1
  , Outcome (1 / 6) 2
  , Outcome (1 / 6) 3
  , Outcome (1 / 6) 4
  , Outcome (1 / 6) 5
  , Outcome (1 / 6) 6
  ]

loaded :: Prob Number Number
loaded = Prob
  [ Outcome (1 / 10) 1
  , Outcome (1 / 10) 2
  , Outcome (1 / 10) 3
  , Outcome (1 / 10) 4
  , Outcome (1 / 10) 5
  , Outcome (1 / 2)  6
  ]

newtype Priority = Priority Number

instance showPriority :: Show Priority where
  show (Priority n) = show n

instance addPriority :: Monoid.AddSemigroup Priority where
  (+) (Priority p) (Priority q) 
    | p > q     = Priority p
    | otherwise = Priority q         

foreign import inf "var inf = Infinity" :: Number

instance addMonoidPriority :: Monoid.AddMonoid Priority where
  zero = Priority (-inf)

instance multPriority :: Monoid.MultSemigroup Priority where
  (*) (Priority p) (Priority q) = Priority (p + q)

instance multSemigroup :: Monoid.MultMonoid Priority where
  one = Priority 0

todo :: Prob Priority String
todo = Prob
  [ Outcome (Priority 10) "Buy a Christmas tree"
  , Outcome (Priority 20) "Buy gifts"
  , Outcome (Priority 5)  "Bake mince pies"
  ]

gifts :: Prob Priority String
gifts = Prob
  [ Outcome (Priority 20) "John"
  , Outcome (Priority 5)  "Mary"
  , Outcome (Priority 30) "Jack"
  ]

main = Debug.Trace.print $ runProb $ normalize do
  task <- todo
  subTask <- case task of
               "Buy gifts" -> gifts
               _ -> return ""
  return $ task <> ": " <> subTask 
