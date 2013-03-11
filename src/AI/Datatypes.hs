module AI.Datatypes where

import Map.Datatypes
import Objects.Datatypes

-- Dummy data
data Building = Building
data BuildingType = BuildingType


data Interupts = Hunger
               | Thirst
               | Danger


data Goal = Dig       Pos
          | Build     BuildingType Pos -- building/structure
          | Move      Pos -- destination
          | Produce   Building ObjectType -- building product
          | Eat       Object
          | Drink     Object
          | Transport Object Pos
            

data Task = Step   Pos
          | PickUp Object
          | Drop   Object
          | Idle   -- Socialisera med mera
          | DoWork

data Flowchart = Flowchart



-- Global Data
{-
Alla användardefinierade uppgifter: listade efter typ
Alla enheters positioner
Alla objekts/byggnader/tiles positioner

-}


-- Funtioner

--findPath :: Position -> Position -> [Position]
--findPath = undefined


--makeDecision :: Flowchart -> CharacterState -> PossibleTasks  -> Task
--makeDecision = undefined