module Map.Datatypes where


import Data.Array
import Objects.Materials




data Pos = Pos Int Int Int

type Path = [Pos]

type Distance = Int

type Map = Array (Int, Int, Int) Tile


data TileStatus = Open | Undug | Blocked

data GroundType = Earth 
                | Stone 
                | Ore Material

data Tile = Tile {ground :: GroundType
                 ,status :: TileStatus}




-- Pos x y z

