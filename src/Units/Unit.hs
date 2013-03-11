module Units.Unit where

import AI.Datatypes
import Map.Datatypes
import Objects.Datatypes

-- Dummy data
data Race = Race



data Unit = Unit{race :: Race
                ,state :: CharacterState}  


data CharacterState = CS {name      :: String
                         ,position  :: Pos
                         ,tasks     :: [Task]
                         ,goal      :: Goal
                         ,inventory :: [Object]
                         ,hunger    :: Int
                         ,thirst    :: Int
                         ,health    :: Health
                         }


data Health = Health {blood :: Int
                     ,limbs :: [(String,Int)] -- name x health
                     ,infections :: [Infection]}

data Infection = Infection