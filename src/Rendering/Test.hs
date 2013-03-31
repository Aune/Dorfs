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
   let view = SimpleMapView {top = 0, left = 0, width = 5, height = 5, level = 0, world = exampleMap}

   SDL.setCaption "Video Test!" "video test"
   mainSurf <- getVideoSurface
   render view mainSurf
   --SDL.blitSurface viewSurf Nothing mainSurf Nothing
   SDL.flip mainSurf

   eventLoop
   SDL.quit
   print "done"
    where 
      eventLoop            = SDL.waitEventBlocking >>= checkEvent
      checkEvent (KeyUp _) = return ()
      checkEvent _         = eventLoop
