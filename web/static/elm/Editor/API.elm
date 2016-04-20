module Editor.API (..) where

import Html exposing (Html)
import StartApp
import Effects exposing (Never)
import Task exposing (Task)
import Editor.Update exposing (update, Action(..), Addresses)
import Editor.Model exposing (Model)
import Editor.View exposing (view)


initialText =
  """
# Heading goes here.

Put [markdown](https://daringfireball.net/projects/markdown/) text here.
"""


app : StartApp.App Model
app =
  let
    initModel : Model
    initModel =
      { text = initialText }

    modelWithEffects =
      ( initModel, Effects.none )

    addresses =
      {}
  in
    StartApp.start
      { init = modelWithEffects
      , view = view
      , update = (update addresses)
      , inputs = []
      }


main : Signal Html
main =
  app.html
