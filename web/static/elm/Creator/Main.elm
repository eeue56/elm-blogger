port module Creator.Main exposing (..) -- where

import Html exposing (Html)
import Html.App as Html

import Creator.Update exposing (router, MessageRouter(..), Msg(..))
import Creator.Model exposing (Model)
import Creator.View exposing (view)
import Component.Editor.API exposing (initialText)

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
            }


        modelWithEffects =
            (initModel, Cmd.none) -- Cmd.map (TopLevel << (\_ -> NoOp)) sendInit )

    in
        Html.program
            { init = modelWithEffects
            , view = view
            , update = router
            , subscriptions = handleSubscriptions
            }



handleSubscriptions : Model -> Sub MessageRouter
handleSubscriptions mode =
    let _ = Debug.log "handleSubscriptions" "te " in
    WebSocket.listen "ws://localhost:4000/socket/websocket" (TopLevel << Payload)


test refNumber =
    stringify
        { payload = {}
        , topic = "editor:other"
        , event = "phx_join"
        , ref = 0
        }

--userToken : (a -> msg) -> Sub msg
