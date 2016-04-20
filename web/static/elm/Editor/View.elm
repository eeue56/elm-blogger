module Editor.View (..) where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Signal

import Editor.Model exposing (..)
import Editor.Update exposing (..)

import Markdown

view : Signal.Address Action -> Model -> Html
view address model =
  div
    [ class "view" ]
    [ h1 [] [ text "Elm Markdown Editor" ]
    , div
        [ class "pure-g panes" ]
        [ div
            [ class "pure-u-1-2 edit" ]
            [ textarea
                [ value model.text
                , on "input" targetValue (Signal.message address << ModifyText)
                , class "inputarea"
                ]
                []
            ]
        , div
            [ class "pure-u-1-2 display" ]
            [ Markdown.toHtml model.text ]
        ]
    ]
