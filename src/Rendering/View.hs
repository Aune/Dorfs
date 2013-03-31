module Rendering.View where

import Graphics.UI.SDL (Surface, Rect)

voxelSize :: Int
voxelSize = 16

class View a where            
  render :: a -> Surface -> IO ()
   