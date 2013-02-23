module Objects.Datatypes where



import Map.Datatypes
import Objects.Materials


data ObjectType = Weapon
                | Tool
                | Food
                | Drink
                | RawMaterials



data Object = Object Pos ObjectType Material