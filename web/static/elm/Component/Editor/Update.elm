module Component.Editor.Update exposing (..) -- where

import Component.Editor.Model exposing (..)


type Msg
  = NoOp
  | ModifyText String


update : Msg -> Model b -> ( Model b, Cmd Msg )
update action model =
  case action of
    NoOp ->
      ( model, Cmd.none )

    ModifyText str ->
      ( { model | inputText = str }, Cmd.none )
