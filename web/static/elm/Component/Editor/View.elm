module Component.Editor.View exposing (..) -- where

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Markdown

import Component.Editor.Model exposing (..)
import Component.Editor.Update exposing (..)



view : Model a -> Html Msg
view model =
  div
    [ class "view" ]
    [ h1 [] [ text "Elm Markdown Editor" ]
    , div
        [ class "pure-g panes" ]
        [ div
            [ class "pure-u-1-2 edit" ]
            [ textarea
                [ value model.inputText
                , onInput ModifyText
                , class "inputarea"
                ]
                []
            ]
        , div
            [ class "pure-u-1-2 display" ]
            [ Markdown.toHtmlWith Markdown.defaultOptions  [] (model.inputText) ]
        , input [ onInput SetChannelName ] []
        ]
    ]
