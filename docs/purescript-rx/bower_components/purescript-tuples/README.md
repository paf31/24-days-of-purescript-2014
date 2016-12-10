# Module Documentation

## Module Data.Tuple

### Types

    data Tuple a b where
      Tuple :: a -> b -> Tuple a b


### Type Class Instances

    instance applicativeTuple :: (Monoid a) => Applicative (Tuple a)

    instance applyTuple :: (Semigroup a) => Apply (Tuple a)

    instance bindTuple :: (Semigroup a) => Bind (Tuple a)

    instance comonadTuple :: Comonad (Tuple a)

    instance eqTuple :: (Eq a, Eq b) => Eq (Tuple a b)

    instance extendTuple :: Extend (Tuple a)

    instance functorTuple :: Functor (Tuple a)

    instance lazyLazy1Tuple :: (Lazy1 l1, Lazy1 l2) => Lazy (Tuple (l1 a) (l2 b))

    instance lazyLazy2Tuple :: (Lazy2 l1, Lazy2 l2) => Lazy (Tuple (l1 a b) (l2 c d))

    instance lazyTuple :: (Lazy a, Lazy b) => Lazy (Tuple a b)

    instance monadTuple :: (Monoid a) => Monad (Tuple a)

    instance monoidTuple :: (Monoid a, Monoid b) => Monoid (Tuple a b)

    instance ordTuple :: (Ord a, Ord b) => Ord (Tuple a b)

    instance semigroupTuple :: (Semigroup a, Semigroup b) => Semigroup (Tuple a b)

    instance semigroupoidTuple :: Semigroupoid Tuple

    instance showTuple :: (Show a, Show b) => Show (Tuple a b)


### Values

    curry :: forall a b c. (Tuple a b -> c) -> a -> b -> c

    fst :: forall a b. Tuple a b -> a

    snd :: forall a b. Tuple a b -> b

    swap :: forall a b. Tuple a b -> Tuple b a

    uncurry :: forall a b c. (a -> b -> c) -> Tuple a b -> c

    unzip :: forall a b. [Tuple a b] -> Tuple [a] [b]

    zip :: forall a b. [a] -> [b] -> [Tuple a b]


## Module Data.Tuple.Nested

### Values

    (/\) :: forall a b. a -> b -> Tuple a b

    con10 :: forall a b c d e f g h i j z. (a -> b -> c -> d -> e -> f -> g -> h -> i -> j -> z) -> Tuple a (Tuple b (Tuple c (Tuple d (Tuple e (Tuple f (Tuple g (Tuple h (Tuple i j)))))))) -> z

    con2 :: forall a b z. (a -> b -> z) -> Tuple a b -> z

    con3 :: forall a b c z. (a -> b -> c -> z) -> Tuple a (Tuple b c) -> z

    con4 :: forall a b c d z. (a -> b -> c -> d -> z) -> Tuple a (Tuple b (Tuple c d)) -> z

    con5 :: forall a b c d e z. (a -> b -> c -> d -> e -> z) -> Tuple a (Tuple b (Tuple c (Tuple d e))) -> z

    con6 :: forall a b c d e f z. (a -> b -> c -> d -> e -> f -> z) -> Tuple a (Tuple b (Tuple c (Tuple d (Tuple e f)))) -> z

    con7 :: forall a b c d e f g z. (a -> b -> c -> d -> e -> f -> g -> z) -> Tuple a (Tuple b (Tuple c (Tuple d (Tuple e (Tuple f g))))) -> z

    con8 :: forall a b c d e f g h z. (a -> b -> c -> d -> e -> f -> g -> h -> z) -> Tuple a (Tuple b (Tuple c (Tuple d (Tuple e (Tuple f (Tuple g h)))))) -> z

    con9 :: forall a b c d e f g h i z. (a -> b -> c -> d -> e -> f -> g -> h -> i -> z) -> Tuple a (Tuple b (Tuple c (Tuple d (Tuple e (Tuple f (Tuple g (Tuple h i))))))) -> z