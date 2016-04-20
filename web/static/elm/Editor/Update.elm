module Editor.Update (..) where

import Effects exposing (Effects)
import Editor.Model exposing (..)


type Action
  = NoOp
  | ModifyText String


type alias Addresses =
  {}


update : Addresses -> Action -> Model -> ( Model, Effects.Effects Action )
update addresses action model =
  case action of
    NoOp ->
      ( model, Effects.none )

    ModifyText str ->
      ( { model | text = str }, Effects.none )
