module Structures.Datatypes where


import Map.Datatypes


data BuildingType = Structure
                  | Workshop
                  | Other

data Building = Building Pos BuidingType

