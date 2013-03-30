module Map.Codecs where

import Map.Datatypes
import Text.Regex.Posix
import Data.Array.IO

fromString :: String -> IO Map
fromString s = buildMap (sizeFromString s) (dataString s)

sizeFromString :: String -> ((Int, Int, Int), (Int, Int, Int))
sizeFromString s = pair (read (firstList s) :: [[Int]] )
  where
    pair :: [[Int]] -> ((Int, Int, Int), (Int, Int, Int))
    pair [[x1, y1, z1], [x2, y2, z2]] = ((x1, y1, z1), (x2, y2, z2))
    firstList s = s =~ "\\[.*\\]" :: String

dataString :: String -> String
dataString s = after $ matchList s
  where
    after :: (String, String, String) -> String
    after (_,_ , a) = a
    matchList s = s =~ "\\[.*\\]" :: (String, String, String)
    
charToTile :: Char -> Tile
charToTile ' ' = Tile Stone Undug
charToTile _   = Tile Stone Open

buildMap :: ((Int, Int, Int), (Int, Int, Int)) -> String -> IO Map
buildMap propagation s = do aMap <- newArray propagation (Tile Stone Undug) :: IO (IOArray (Int, Int, Int) Tile)
                            mapM_ (updateTile aMap) (zip (range propagation) tiles)
                            return aMap
  where
    tiles = [charToTile(x)| x <- s, x /= '\n']
    updateTile arr (pos, tile) = writeArray arr pos tile
    

exampleMap = fromString "[[0,0,0],[5,5,1]]aaaa aaaa aaaa aaaa aaaa "
