module Rendering.Datatypes where




import Graphics.UI.SDL as SDL



data Bindings key = Bindings {getBindings :: [(key,SDL.Surface)]}

mkBindings :: SDL.Surface -> [key] -> Bindings key
mkBindings = undefined 