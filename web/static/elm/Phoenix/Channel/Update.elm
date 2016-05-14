module Phoenix.Channel.Update exposing (..) -- where


import Phoenix.Channel.Model exposing (..)
import Json.Decode exposing (decodeString)

type ServerResponse
  = SuccessfulResponse SocketResponse
  | ErrorResponse String


turnDecodedResponseIntoServerResponse : Result String SocketResponse -> ServerResponse
turnDecodedResponseIntoServerResponse response =
  case response of
    Ok socketResponse ->
      case socketResponse.payload.status of
        "ok" ->
          SuccessfulResponse socketResponse
        _ ->
          ErrorResponse (socketResponse.payload.status)
    Err message ->
      ErrorResponse message


assignResponseType : String -> ServerResponse
assignResponseType =
    decodeString decodeSocketResponse
      >> turnDecodedResponseIntoServerResponse


update : ServerResponse -> Model a -> (Model a, Cmd ServerResponse)
update response model =
  case response of
    ErrorResponse string ->
      let
        _ =
          Debug.log "Error from websocket: " string
      in
        (model, Cmd.none)

    SuccessfulResponse response ->
      let
        payload =
          response.payload

        status =
          payload.status

        newModel =
          case status of
            "ok" ->
              { model
                | refNumber = (model.refNumber + 1)
                , connected = True
                , socketEvents = (response :: model.socketEvents)
              }
            _ ->
              model
      in
        ( newModel, Cmd.none )
