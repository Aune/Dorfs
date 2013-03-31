module Rendering.View where

import Map.Datatypes

import Graphics.UI.SDL as SDL
import Graphics.UI.SDL.Image as SDLi

voxelSize = 16

data View = View { top :: Int,
                   left :: Int,
                   width :: Int,
                   height :: Int,
                   level :: Int,
                   world :: IO Map}
            
right v = (left v) + (width v) - 1
bottom v = (top v) + (height v) - 1 

render :: View -> SDL.Surface -> IO ()
render v surface =  do mapM_ (blitPos v surface) (paintRange v)
                       return ()
  where 
    paintRange :: View -> [Pos]
    paintRange v = [(Pos x y (level v)) | 
                    y <- [(top v)..(bottom v)],
                    x <- [(left v)..(right v)] ]   
 
          
    posToRect :: Pos -> View -> Rect
    posToRect (Pos x y z) v = Rect ((x - (left v)) * voxelSize) 
                                   ((y - (top v)) * voxelSize)  
                                   voxelSize voxelSize
        
    tileRect :: Tile -> Rect
    tileRect Tile {status = Open} = Rect 176 208 voxelSize voxelSize
    tileRect _ = Rect 112 176 voxelSize voxelSize
                                  
    tileSurface = SDLi.load "res/test/Phoebus_16x16.png"
                 
    blitTile :: Tile -> Rect -> SDL.Surface-> SDL.Surface -> IO ()
    blitTile t r src dst = do SDL.blitSurface src (Just (tileRect t))  dst (Just r) 
                              return ()
                        
    blitPos :: View -> SDL.Surface -> Pos -> IO ()
    blitPos v dst p  =  do 
      tile <- (world v) >>= tileAtPos p       
      src <- tileSurface
      blitTile tile (posToRect p v) src dst
