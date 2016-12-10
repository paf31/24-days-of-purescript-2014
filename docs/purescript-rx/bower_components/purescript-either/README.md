# Module Documentation

## Module Data.Either

### Types

    data Either a b where
      Left :: a -> Either a b
      Right :: b -> Either a b


### Type Class Instances

    instance altEither :: Alt (Either e)

    instance applicativeEither :: Applicative (Either e)

    instance applyEither :: Apply (Either e)

    instance bindEither :: Bind (Either e)

    instance eqEither :: (Eq a, Eq b) => Eq (Either a b)

    instance functorEither :: Functor (Either a)

    instance monadEither :: Monad (Either e)

    instance ordEither :: (Ord a, Ord b) => Ord (Either a b)

    instance showEither :: (Show a, Show b) => Show (Either a b)


### Values

    either :: forall a b c. (a -> c) -> (b -> c) -> Either a b -> c

    isLeft :: forall a b. Either a b -> Boolean

    isRight :: forall a b. Either a b -> Boolean


## Module Data.Either.Nested

### Values

    choice10 :: forall a b c d e f g h i j z. (a -> z) -> (b -> z) -> (c -> z) -> (d -> z) -> (e -> z) -> (f -> z) -> (g -> z) -> (h -> z) -> (i -> z) -> (j -> z) -> Either a (Either b (Either c (Either d (Either e (Either f (Either g (Either h (Either i j)))))))) -> z

    choice2 :: forall a b z. (a -> z) -> (b -> z) -> Either a b -> z

    choice3 :: forall a b c z. (a -> z) -> (b -> z) -> (c -> z) -> Either a (Either b c) -> z

    choice4 :: forall a b c d z. (a -> z) -> (b -> z) -> (c -> z) -> (d -> z) -> Either a (Either b (Either c d)) -> z

    choice5 :: forall a b c d e z. (a -> z) -> (b -> z) -> (c -> z) -> (d -> z) -> (e -> z) -> Either a (Either b (Either c (Either d e))) -> z

    choice6 :: forall a b c d e f z. (a -> z) -> (b -> z) -> (c -> z) -> (d -> z) -> (e -> z) -> (f -> z) -> Either a (Either b (Either c (Either d (Either e f)))) -> z

    choice7 :: forall a b c d e f g z. (a -> z) -> (b -> z) -> (c -> z) -> (d -> z) -> (e -> z) -> (f -> z) -> (g -> z) -> Either a (Either b (Either c (Either d (Either e (Either f g))))) -> z

    choice8 :: forall a b c d e f g h z. (a -> z) -> (b -> z) -> (c -> z) -> (d -> z) -> (e -> z) -> (f -> z) -> (g -> z) -> (h -> z) -> Either a (Either b (Either c (Either d (Either e (Either f (Either g h)))))) -> z

    choice9 :: forall a b c d e f g h i z. (a -> z) -> (b -> z) -> (c -> z) -> (d -> z) -> (e -> z) -> (f -> z) -> (g -> z) -> (h -> z) -> (i -> z) -> Either a (Either b (Either c (Either d (Either e (Either f (Either g (Either h i))))))) -> z