module Component.Editor.Update exposing (..) -- where

import Json.Encode
import Component.Editor.Model exposing (..)
import Phoenix.Channel.Update as ChannelUpdate

type Msg
  = NoOp
  | ModifyText String
  | SetChannelName String
  | ChannelUpdate ChannelUpdate.Msg


buildJson model =
  let
    event =
      if model.connected then
         "new_msg"
      else
        "phx_join"
  in
    { payload = Json.Encode.string model.channelName
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

        (newModel, command) =
          update (ChannelUpdate <| ChannelUpdate.SendMessage jsonToSend) model
      in
        ( { newModel | channelName = string }, command )

    ChannelUpdate action ->
      let
        (model', effect) =
          ChannelUpdate.update action model
      in
        ( model', Cmd.map (ChannelUpdate) effect )




