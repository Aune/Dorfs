module Main where

import Rendering.View
import Map.Codec
import Graphics.UI.SDL as SDL
import Graphics.UI.SDL.Image as SDLi

main :: IO ()
main = do 
   SDL.init [SDL.InitEverything]
   SDL.setVideoMode 640 480 32 []
   
   let view = View {top = 0, left = 0, width = 3, height = 3, level = 0, world = exampleMap}

   SDL.setCaption "Video Test!" "video test"
   mainSurf <- getVideoSurface
   viewSurf <- render view
   SDL.blitSurface viewSurf Nothing mainSurf Nothing
   SDL.flip mainSurf

   eventLoop
   SDL.quit
   print "done"
    where 
      eventLoop            = SDL.waitEventBlocking >>= checkEvent
      checkEvent (KeyUp _) = return ()
      checkEvent _         = eventLoop
