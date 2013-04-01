module Main where

import Rendering.SimpleMapView
import Rendering.View
import Map.Codec
import Graphics.UI.SDL as SDL
import Graphics.UI.SDL.Image as SDLi

main :: IO ()
main = do 
   SDL.init [SDL.InitEverything]
   SDL.setVideoMode 640 480 32 []
   
   let exampleMap = fromString "[[0,0,0],[4,4,0]] 2345\n1 345\n12 45\n123 5\n1234 "
   let view = SimpleMapView {top = 10, left = 20, level = 0, world = exampleMap}
   let paintRect = Rect 0 0 100 100
   SDL.setCaption "Video Test!" "video test"
   mainSurf <- getVideoSurface
   
   render view paintRect mainSurf
   --SDL.blitSurface viewSurf Nothing mainSurf Nothing
   SDL.flip mainSurf

   eventLoop
   SDL.quit
   print "done"
    where 
      eventLoop            = SDL.waitEventBlocking >>= checkEvent
      checkEvent (KeyUp _) = return ()
      checkEvent _         = eventLoop
