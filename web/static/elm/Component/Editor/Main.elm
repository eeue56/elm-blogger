module Component.Editor.Main exposing (..) -- where

import Html exposing (Html)
import Html.App as Html
import Component.Editor.Update exposing (update)
import Component.Editor.Model exposing (Model)
import Component.Editor.View exposing (view)
import Component.Editor.API exposing (initialText)

main =
    let
        initModel : Model {}
        initModel =
            { inputText = initialText
            , channelName = ""
            , refNumber = 0
            , connected = False
            , socketUrl = ""
            }

        modelWithEffects =
            (initModel, Cmd.none)

    in
        Html.program
            { init = modelWithEffects
            , view = view
            , update = update
            , subscriptions = (\_ -> Sub.none)
            }
