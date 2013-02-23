module AI.Actions where


import AI.Datatypes
import Map.Datatypes
import Objects.Datatypes
import Units.Unit



findPath :: Pos -> Pos -> Maybe Path
findPath = undefined

chooseGoal :: Map -> Unit -> [Goal] -> Goal 
chooseGoal = undefined

currentTask :: Unit -> Task
currentTask = undefined


findClosest :: ObjectType -> Maybe (Distance,Object)
findClosest = undefined