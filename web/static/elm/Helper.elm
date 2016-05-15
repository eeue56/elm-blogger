module Helper exposing (stringify) --where

import Json.Encode

stringify : Json.Encode.Value -> String
stringify =
    Json.Encode.encode 0
