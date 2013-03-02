module Rendering.Test where


import Map.Datatypes
import Objects.Datatypes
import Structures.Datatypes
import Rendering.Datatypes

import Graphics.UI.SDL as SDL
import Graphics.UI.SDL.Image as SDLi

main :: IO ()
main = do 
   SDL.init [SDL.InitEverything]
   SDL.setVideoMode 640 480 32 []
   
   -- Load images
   image <- SDLi.load "Rendering/Images/Phoebus_16x16.png"
            

   SDL.setCaption "Video Test!" "video test"
   mainSurf <- getVideoSurface
   let r = Just (Rect 0 0 64 74)
   SDL.blitSurface image r mainSurf Nothing
   SDL.flip mainSurf

   eventLoop
   SDL.quit
   print "done"
    where 
      eventLoop = SDL.waitEventBlocking >>= checkEvent
      checkEvent (KeyUp _) = return ()
      checkEvent _         = eventLoop
