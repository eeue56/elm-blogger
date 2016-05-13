module Creator.View exposing (..) -- where

import Html.App as Html
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

import Creator.Model exposing (..)
import Creator.Update exposing (..)
import Component.Editor.View as EditorView


view : Model -> Html MessageRouter
view model =
    Html.map EditorLevel (EditorView.view model)
