module Main where
  
import Graphics.D3.Util
import Graphics.D3.Selection

array = [ { label: "Nice"
          , count: 92
          }
        , { label: "Naughty"
          , count: 8
          }
        ]

main = do
  g <- rootSelect ".chart"
    .. selectAll "g"
    .. bind array 
    .. enter
      .. append "g"
  
  g # append "rect"
          .. attr'' "x"      (\_ i -> i * 100)
          .. attr'  "y"      (\o -> 100 - o.count)
          .. attr   "width"  98
          .. attr'  "height" (\o -> o.count)

          .. style  "stroke-width" "1"
          .. style  "stroke"       "rgb(0,255,0)"
          
  g # append "text"
            .. attr'' "x"  (\_ i -> i * 100 + 20)
            .. attr   "y"  120
            .. text'       (\o -> o.label ++ " (" ++ show o.count ++ "%)")
