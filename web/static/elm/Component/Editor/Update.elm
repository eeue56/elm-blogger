module Component.Editor.Update exposing (..) -- where

import Component.Editor.Model exposing (..)
import Helper exposing (stringify)
import MyWebSocket

type Msg
  = NoOp
  | ModifyText String
  | SetChannelName String


buildJson model =
  let
    event =
      if model.connected then
         "new_msg"
      else
        "phx_join"
  in
    stringify
        { payload = model.channelName
        , topic = "editor:other"
        , event = event
        , ref = model.refNumber
        }

update : Msg -> Model b -> ( Model b, Cmd Msg )
update action model =
  case action of
    NoOp ->
      ( model, Cmd.none )

    ModifyText str ->
      ( { model | inputText = str }, Cmd.none )

    SetChannelName string ->
      let
        jsonToSend =
          buildJson model

        command =
          MyWebSocket.send jsonToSend
          

        _ = Debug.log "Payload" jsonToSend

      in
        ( { model | channelName = string }, command )




