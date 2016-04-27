module Creator.Main exposing (..) -- where

import Html exposing (Html)
import Html.App as Html

import Creator.Update exposing (router, MessageRouter(..))
import Creator.Model exposing (Model)
import Creator.View exposing (view)
import Component.Editor.API exposing (initialText)


main =
    let
        initModel : Model
        initModel =
            { inputText = initialText }

        modelWithEffects =
            (initModel, Cmd.none)

    in
        Html.program
            { init = modelWithEffects
            , view = view
            , update = router
            , subscriptions = (\_ -> Sub.none)
            }

