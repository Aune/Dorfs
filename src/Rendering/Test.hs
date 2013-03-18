
module Main where

import Graphics.UI.SDL as SDL
import Graphics.UI.SDL.Image as SDLi

main :: IO ()
main = do 
   SDL.init [SDL.InitEverything]
   SDL.setVideoMode 640 480 32 []
   
   -- Load images
   image <- SDLi.load "res/test/Phoebus_16x16.png"
            

   SDL.setCaption "Video Test!" "video test"
   mainSurf <- getVideoSurface
   let blitRect (src, dst) = SDL.blitSurface image src mainSurf dst
   mapM_ blitRect [(Just (Rect (240 - i) (240 - j) 16 16),Just (Rect i j 16 16))  | j <- [0..255], i <- [0..255], mod i 16  == 0, mod j 16 == 0]
   SDL.flip mainSurf

   eventLoop
   SDL.quit
   print "done"
    where 
      eventLoop            = SDL.waitEventBlocking >>= checkEvent
      checkEvent (KeyUp _) = return ()
      checkEvent _         = eventLoop
