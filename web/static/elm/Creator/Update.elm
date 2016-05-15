module Creator.Update exposing (..) -- where

import Json.Encode
import Creator.Model exposing (..)
import Component.Editor.Update as EditorUpdate


type Msg
  = NoOp


type MessageRouter
  = TopLevel Msg
  | EditorLevel EditorUpdate.Msg


update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    NoOp ->
      (model, Cmd.none)



{-| We use this router for composing our messages and components together
Each component provides an API which is scoped through MessageRouter.
-}
router : MessageRouter -> Model -> (Model, Cmd MessageRouter)
router route model =
  case route of
    TopLevel action ->
      let
        (model', effect) =
          update action model
      in
        ( model', Cmd.map (TopLevel) effect )

    EditorLevel action ->
      let
        (model', effect) =
          EditorUpdate.update action model
      in
        ( model', Cmd.map (EditorLevel) effect )

