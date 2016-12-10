module Example where

import Optic.Lens
import Optic.Types
import Optic.Prism

data Person = Person { name :: String
                     , addr :: Address
                     , type :: PersonType
                     }

data Address = Address { street :: String
                       , city :: String
                       }

data PersonType = Naughty | Nice

instance showPerson :: Show Person where
  show (Person p) =
    "(Person " ++ show p.name ++
    " " ++ show p.addr ++
    " " ++ show p.type ++ ")"

instance showAddress :: Show Address where
  show (Address a) =
    "(Address " ++ show a.street ++
    " " ++ show a.city ++ ")"

instance showPersonType :: Show PersonType where
  show Naughty = "Naughty"
  show Nice    = "Nice"

instance eqPersonType :: Eq PersonType where
  (==) Naughty Naughty = true
  (==) Nice    Nice    = true
  (==) _       _       = false
  (/=) x       y       = not (x == y)

examplePerson :: Person
examplePerson = Person { name: "John Smith"
                       , addr: Address { street: "123 Fake St."
                                       , city: "Los Angeles"
                                       }
                       , type: Naughty 
                       }
                                        

name :: LensP Person String
name = lens (\(Person p) -> p.name) (\(Person p) name -> Person (p { name = name }))

address :: LensP Person Address
address = lens (\(Person p) -> p.addr) (\(Person p) addr -> Person (p { addr = addr }))

_type :: LensP Person PersonType
_type = lens (\(Person p) -> p.type) (\(Person p) ty -> Person (p { type = ty }))

street :: LensP Address String
street = lens (\(Address a) -> a.street) (\(Address a) street -> Address (a { street = street }))

city :: LensP Address String
city = lens (\(Address a) -> a.city) (\(Address a) city -> Address (a { city = city }))

nice :: PrismP PersonType Unit
nice = only Nice

naughty :: PrismP PersonType Unit
naughty = only Naughty

