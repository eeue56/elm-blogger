module Component.Editor.View (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal
import Markdown

import Component.Editor.Model exposing (..)
import Component.Editor.Update exposing (..)


view : Addresses a -> Signal.Address Action -> Model b -> Html
view addresses _ model =
  div
    [ class "view" ]
    [ h1 [] [ text "Elm Markdown Editor" ]
    , div
        [ class "pure-g panes" ]
        [ div
            [ class "pure-u-1-2 edit" ]
            [ textarea
                [ value model.inputText
                , on "input" targetValue (Signal.message addresses.editor << ModifyText)
                , class "inputarea"
                ]
                []
            ]
        , div
            [ class "pure-u-1-2 display" ]
            [ Markdown.toHtml model.inputText ]
        ]
    ]
