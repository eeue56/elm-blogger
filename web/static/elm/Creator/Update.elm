module Creator.Update where

import Effects exposing (Effects)
import Creator.Model exposing (..)
import Component.Editor.Update as EditorUpdate

type Action
  = NoOp

type alias Addresses =
  { editor : Signal.Address EditorUpdate.Action
  , top : Signal.Address Action
  }

type MessageRouter
  = TopLevel Action
  | EditorLevel EditorUpdate.Action

update : Addresses -> Action -> Model -> (Model, Effects.Effects Action)
update addresses action model =
  case action of
    NoOp ->
      (model, Effects.none)


{-| We use this router for composing our actions and components together
Each component provides an API which is scoped through MessageRouter.
In order for cross-component communication, we expose the addresses to each component.
From there, they can trigger Actions elsehwere.
-}
router : Addresses -> MessageRouter -> Model -> (Model, Effects.Effects MessageRouter)
router addresses route model =
  case route of
    TopLevel action ->
      let
        (model, effect) =
          update addresses action model
      in
        ( model, Effects.map (TopLevel) effect )

    EditorLevel action ->
      let
        (model, effect) =
          EditorUpdate.update addresses action model
      in
        ( model, Effects.map (EditorLevel) effect )
