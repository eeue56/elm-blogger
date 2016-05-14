module Helper exposing (stringify) --where

import Native.Stringify

stringify : a -> String
stringify =
    Native.Stringify.stringify
