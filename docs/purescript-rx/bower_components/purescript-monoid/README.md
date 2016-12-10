# Module Documentation

## Module Data.Monoid

### Type Classes

    class (Semigroup m) <= Monoid m where
      mempty :: m


### Type Class Instances

    instance monoidArr :: (Monoid b) => Monoid (a -> b)

    instance monoidArray :: Monoid [a]

    instance monoidMaybe :: (Semigroup a) => Monoid (Maybe a)

    instance monoidString :: Monoid String

    instance monoidUnit :: Monoid Unit


## Module Data.Monoid.All

### Types

    newtype All where
      All :: Boolean -> All


### Type Class Instances

    instance eqAll :: Eq All

    instance monoidAll :: Monoid All

    instance semigroupAll :: Semigroup All

    instance showAll :: Show All


### Values

    runAll :: All -> Boolean


## Module Data.Monoid.Any

### Types

    newtype Any where
      Any :: Boolean -> Any


### Type Class Instances

    instance eqAny :: Eq Any

    instance monoidAny :: Monoid Any

    instance semigroupAny :: Semigroup Any

    instance showAny :: Show Any


### Values

    runAny :: Any -> Boolean


## Module Data.Monoid.Dual

### Types

    newtype Dual a where
      Dual :: a -> Dual a


### Type Class Instances

    instance eqDual :: (Eq a) => Eq (Dual a)

    instance monoidDual :: (Monoid a) => Monoid (Dual a)

    instance ordDual :: (Ord a) => Ord (Dual a)

    instance semigroupDual :: (Semigroup a) => Semigroup (Dual a)

    instance showDual :: (Show a) => Show (Dual a)


### Values

    runDual :: forall a. Dual a -> a


## Module Data.Monoid.Endo

### Types

    newtype Endo a where
      Endo :: a -> a -> Endo a


### Type Class Instances

    instance monoidEndo :: Monoid (Endo a)

    instance semigroupEndo :: Semigroup (Endo a)


### Values

    runEndo :: forall a. Endo a -> a -> a


## Module Data.Monoid.First

### Types

    newtype First a where
      First :: Maybe a -> First a


### Type Class Instances

    instance eqFirst :: (Eq a) => Eq (First a)

    instance monoidFirst :: Monoid (First a)

    instance ordFirst :: (Ord a) => Ord (First a)

    instance semigroupFirst :: Semigroup (First a)

    instance showFirst :: (Show a) => Show (First a)


### Values

    runFirst :: forall a. First a -> Maybe a


## Module Data.Monoid.Last

### Types

    newtype Last a where
      Last :: Maybe a -> Last a


### Type Class Instances

    instance eqLast :: (Eq a) => Eq (Last a)

    instance monoidLast :: Monoid (Last a)

    instance ordLast :: (Ord a) => Ord (Last a)

    instance semigroupLast :: Semigroup (Last a)

    instance showLast :: (Show a) => Show (Last a)


### Values

    runLast :: forall a. Last a -> Maybe a


## Module Data.Monoid.Product

### Types

    newtype Product where
      Product :: Number -> Product


### Type Class Instances

    instance eqProduct :: Eq Product

    instance monoidProduct :: Monoid Product

    instance ordProduct :: Ord Product

    instance semigroupProduct :: Semigroup Product

    instance showProduct :: Show Product


### Values

    runProduct :: Product -> Number


## Module Data.Monoid.Sum

### Types

    newtype Sum where
      Sum :: Number -> Sum


### Type Class Instances

    instance eqSum :: Eq Sum

    instance monoidSum :: Monoid Sum

    instance ordSum :: Ord Sum

    instance semigroupSum :: Semigroup Sum

    instance showSum :: Show Sum


### Values

    runSum :: Sum -> Number