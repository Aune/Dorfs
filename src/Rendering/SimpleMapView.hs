module Rendering.SimpleMapView  where

import Rendering.View
import Map.Datatypes
--import Graphics.UI.SDL (Surface, Rect, blitSurface)

import Graphics.UI.SDL as SDL
import Graphics.UI.SDL.Image as SDLi

-- The drawn surface has it's origo at the same place as the world,

data SimpleMapView = SimpleMapView { top :: Int, -- Pixel offset of whole Map
                                     left :: Int,-- Pixel offset of whole Map
                                     level :: Int, -- Focus layer
                                     world :: IO Map}
                     
cull :: Rect -> Rect -> Rect 
cull outer inner = Rect (max (rectX outer) (rectX inner))
                        (max (rectY outer) (rectY inner))
                        (min (right outer) (right inner))
                        (min (bottom outer) (bottom inner)) 
                   where
                     right rect = (rectX rect) + (rectW rect) - 1
                     bottom rect = (rectY rect) + (rectH rect) - 1 
                     
visiblePos :: SimpleMapView -> Rect -> [Pos]
visiblePos view rect = [(Pos x y (level view)) | x <- [leftPos..rightPos], y <- [topPos..bottomPos]] 
                       where
                         leftPos = mod (left view) voxelSize
                         rightPos = mod ((left view) + (rectW rect)) voxelSize
                         topPos = mod (top view) voxelSize
                         bottomPos = mod ((top view) + (rectH rect)) voxelSize

tileRect :: Tile -> Rect
tileRect Tile {status = Open} = Rect 176 208 voxelSize voxelSize
tileRect _ = Rect 112 176 voxelSize voxelSize
                                  
tileSurface = SDLi.load "res/test/Phoebus_16x16.png"


instance View SimpleMapView where            
  render view paintRect surface = do rectPairs <- mapM posRectMapping (visiblePos view paintRect)
                                     mapM_  blitRects rectPairs
                                     return ()
    where
      posTextureRect :: Pos -> IO Rect
      posTextureRect pos = (world view) >>= (tileAtPos pos) >>= return . tileRect 

      posScreenRect :: Pos -> Rect
      posScreenRect (Pos x y _) = cull paintRect $ Rect ((x * voxelSize) - (left view)) 
                                  ((y * voxelSize) - (top view)) voxelSize voxelSize
      
      posRectMapping :: Pos -> IO (Rect, Rect)
      posRectMapping pos = posTextureRect pos >>= (\x -> return (x, (posScreenRect pos)))
      
      blitRects :: (Rect, Rect) -> IO ()
      blitRects (src, dst) = tileSurface >>= \x -> SDL.blitSurface x (Just src) surface (Just dst) >> return ()