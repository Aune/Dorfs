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

render :: View -> IO SDL.Surface
render v =  do surface <- buildSurface v
               mapM_ (blitPos v surface) (paintRange v)
               return surface
  where 
    buildSurface :: View -> IO SDL.Surface
    buildSurface v = SDL.createRGBSurface [SDL.SWSurface] (width v) (height v) 
                     32 0xFF 0xFF00 0xFF0000 0x00000000
    
    paintRange :: View -> [Pos]
    paintRange v = [(Pos x y (level v)) | 
                    x <- [(left v)..(right v)],   
                    y <- [(top v)..(bottom v)] ]
          
    posToRect :: Pos -> View -> Rect
    posToRect (Pos x y z) v = Rect (x - (left v)) (y - (top v)) voxelSize voxelSize
        
    tileRect :: Tile -> Rect
    tileRect Tile {status = Open} = Rect 176 208 voxelSize voxelSize
    tileRect _ = Rect 112 176 voxelSize voxelSize
                                  
    tileSurface = SDLi.load "res/test/Phoebus_16x16.png"
                 
    blitTile :: Tile -> Rect -> SDL.Surface-> SDL.Surface -> IO ()
    blitTile t r src dst = SDL.blitSurface src (Just (tileRect t)) 
                                           dst (Just r)  
                           >> (return ())
                        
    blitPos :: View -> SDL.Surface -> Pos -> IO ()
    blitPos v dst p  =  do 
      tile <- (world v) >>= tileAtPos p       
      src <- tileSurface
      blitTile tile (posToRect p v) src dst
