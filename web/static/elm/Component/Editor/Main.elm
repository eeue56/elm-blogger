module Component.Editor.Main where

import Html exposing (Html)
import StartApp
import Effects exposing (Never)
import Task exposing (Task)

import Component.Editor.Update exposing (update, Action(..), Addresses)
import Component.Editor.Model exposing (Model)
import Component.Editor.View exposing (view)
import Component.Editor.API exposing (editorMailbox, initialText)

app : StartApp.App (Model {})
app =
  let
    initModel : Model {}
    initModel =
      { inputText = initialText }

    modelWithEffects =
      ( initModel, Effects.none )

    addresses =
      { editor = editorMailbox.address }
  in
    StartApp.start
      { init = modelWithEffects
      , view = (view addresses)
      , update = (update addresses)
      , inputs = [ editorMailbox.signal ]
      }


main : Signal Html
main =
  app.html
