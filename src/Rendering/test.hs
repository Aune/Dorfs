module Rendering.Test where


import Map.Datatypes
import Object.Datatypes
import Structures.Datatypes


import Rendering.UI.SDL as SDL
import Rendering.UI.SDL.Image as SDLi

main :: IO ()
main = do 
   SDL.init [initEverything]
   SDL.setVideoMode 640 480 32 []
   image <- SDLi.load "Rendering/Image/Phoebus_16x16.png"
            

   SDL.setCaption "Video Test!" "video test"
   eventLoop
   SDL.quit
   print "done"
    where 
      eventloop = undefined
