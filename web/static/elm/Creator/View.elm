module Creator.View (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal

import Creator.Model exposing (..)
import Creator.Update exposing (..)
import Component.Editor.View as EditorView


view : Addresses -> Signal.Address dontcare -> Model -> Html
view addresses _ model =
    EditorView.view addresses addresses.editor model
