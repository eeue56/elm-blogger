port module Creator.Main exposing (..) -- where

import Html exposing (Html)
import Html.App as Html

import Creator.Update exposing (router, MessageRouter(..), Msg(..))
import Creator.Model exposing (Model)
import Creator.View exposing (view)
import Component.Editor.API exposing (initialText)
import Phoenix.Channel.Update exposing (assignResponseType)

import MyWebSocket
import WebSocket
import Helper exposing (stringify)

main =
    let
        initModel : Model
        initModel =
            { inputText = "dog"
            , channelName = ""
            , refNumber = 0
            , connected = False
            , socketEvents = []
            }


        modelWithEffects =
            (initModel, Cmd.none)

    in
        Html.program
            { init = modelWithEffects
            , view = view
            , update = router
            , subscriptions = handleSubscriptions
            }

handleSubscriptions : Model -> Sub MessageRouter
handleSubscriptions mode =
    WebSocket.listen "ws://localhost:4000/socket/websocket" (ChannelLevel << assignResponseType)

