module Map.Datatypes where


import Data.Array.IO
import Objects.Materials

data Pos = Pos Int Int Int
  deriving (Eq, Ord, Show)
           

type Path = [Pos]

type Distance = Int

type Map = IOArray (Int, Int, Int) Tile

data TileStatus = Open | Undug | Blocked
  deriving (Eq, Ord, Show)
           
data GroundType = Earth 
                | Stone 
                | Ore Material
                  
  deriving (Eq, Ord, Show)
           
data Tile = Tile {ground :: GroundType
                 ,status :: TileStatus}
  deriving (Eq, Ord, Show)



-- Pos x y z

