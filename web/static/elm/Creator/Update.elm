module Creator.Update exposing (..) -- where

import Creator.Model exposing (..)
import Component.Editor.Update as EditorUpdate
import MyWebSocket
import Json.Encode

import Helper exposing (stringify)
import Json.Decode exposing (..) 
import Json.Decode.Pipeline as Pipeline

type Msg
  = NoOp
  | Payload String


type MessageRouter
  = TopLevel Msg
  | EditorLevel EditorUpdate.Msg


update : Msg -> Model -> (Model, Cmd Msg)
update action model =
  case action of
    NoOp ->
      (model, Cmd.none)
    Payload string ->
      let
        decodedResponse : Result String SocketResponse
        decodedResponse =
          decodeString decodeSocketResponse string

        newModel : Model
        newModel = 
          case decodedResponse of
            Ok response ->
              let
                _ = Debug.log "response" response

                payload =
                  response.payload

                status =
                  payload.status
              in
                case status of
                  "ok" ->
                    { model
                      | refNumber = (model.refNumber + 1)
                      , connected = True
                    }
                  _ ->
                    model
            Err error ->
              let _ = Debug.log "error" error in
              model

      in
        ( newModel, Cmd.none )


decodeSocketResponse : Decoder SocketResponse
decodeSocketResponse =
  Pipeline.decode SocketResponse
    |> Pipeline.required "topic" (string)
    |> Pipeline.optional "ref" (int) (-1)
    |> Pipeline.required "payload" (decodeResponsePayload)
    |> Pipeline.required "event" (string)


decodeResponsePayload : Decoder ResponsePayload
decodeResponsePayload =
  Pipeline.decode ResponsePayload
    |> Pipeline.required "status" (string)
    |> Pipeline.required "response" decodeResponse

decodeResponse : Decoder Response
decodeResponse =
  Pipeline.decode Response
    |> Pipeline.optional "reason" (string) "NULL"

type alias Response =
  { reason : String }

type alias SocketResponse =
  { topic : String
  , ref : Int
  , payload : ResponsePayload
  , event : String
  }

type alias ResponsePayload =
  { status : String
  , response : Response
  }


-- topic":"editor:other","event":"phx_join","payload":{},"ref":"1"}
{-| We use this router for composing our messages and components together
Each component provides an API which is scoped through MessageRouter.
-}
router : MessageRouter -> Model -> (Model, Cmd MessageRouter)
router route model =
  case route of
    TopLevel action ->
      let
        (model', effect) =
          update action model
      in
        ( model', Cmd.map (TopLevel) effect )

    EditorLevel action ->
      let
        (model', effect) =
          EditorUpdate.update action model
      in
        ( model', Cmd.map (EditorLevel) effect )

