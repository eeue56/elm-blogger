module Creator.Main where

import Html exposing (Html)
import StartApp
import Effects exposing (Never)
import Task exposing (Task)

import Creator.Update exposing (router, MessageRouter(..))
import Creator.Model exposing (Model)
import Creator.View exposing (view)
import Creator.API exposing (..)
import Component.Editor.API exposing (initialText, editorMailbox)



app : StartApp.App Model
app =
    let
        initModel : Model
        initModel =
            { inputText = initialText }

        modelWithEffects =
            (initModel, Effects.none)

        addresses =
            { editor = editorMailbox.address
            , top = creatorMailbox.address
            }
    in
        StartApp.start
            { init = modelWithEffects
            , view = (view addresses)
            , update = (router addresses)
            , inputs =
              [ Signal.map (EditorLevel) editorMailbox.signal
              , Signal.map (TopLevel) creatorMailbox.signal
              ]
            }

main : Signal Html
main =
    app.html

port tasks : Signal (Task.Task Never ())
port tasks =
    app.tasks
