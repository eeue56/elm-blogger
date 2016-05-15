port module Creator.Main exposing (..) -- where

import Html exposing (Html)
import Html.App as Html

import Creator.Update exposing (router, MessageRouter(..), Msg(..))
import Creator.Model exposing (Model)
import Creator.View exposing (view)
import Component.Editor.API exposing (initialText)
import Component.Editor.Update exposing (Msg(ChannelUpdate))
import Phoenix.Channel.Helpers exposing (assignResponseType)


import WebSocket

main =
    let
        initModel : Model
        initModel =
            { inputText = initialText
            , channelName = ""
            , refNumber = 0
            , connected = False
            , socketEvents = []
            , socketUrl = "ws://localhost:4000/socket/websocket"
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
handleSubscriptions model =
    WebSocket.listen model.socketUrl (EditorLevel << ChannelUpdate << assignResponseType)

