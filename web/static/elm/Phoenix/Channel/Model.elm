module Phoenix.Channel.Model exposing (..) -- where

import Json.Decode exposing (..)
import Json.Decode.Pipeline as Pipeline


type alias Response =
  { reason : String }

type alias ResponsePayload =
  { status : String
  , response : Response
  }

type alias SocketResponse =
  { topic : String
  , ref : Int
  , payload : ResponsePayload
  , event : String
  }

type alias Model a =
  { a
  | socketEvents : List SocketResponse
  , refNumber : Int
  , connected : Bool
  }


maybeNull : Decoder a -> Decoder (Maybe a)
maybeNull decoder =
  Json.Decode.oneOf [ Json.Decode.null Nothing, Json.Decode.map Just decoder ]

decodeRef : Decoder Int
decodeRef =
  Json.Decode.map (Maybe.withDefault -1) (maybeNull Json.Decode.int)

decodeSocketResponse : Decoder SocketResponse
decodeSocketResponse =
  Pipeline.decode SocketResponse
    |> Pipeline.required "topic" (string)
    |> Pipeline.optional "ref" decodeRef (-1)
    |> Pipeline.required "payload" (decodeResponsePayload)
    |> Pipeline.required "event" (string)


decodeResponsePayload : Decoder ResponsePayload
decodeResponsePayload =
  Pipeline.decode ResponsePayload
    |> Pipeline.required "status" (string)
    |> Pipeline.optional "response" decodeResponse ({ reason = ""})

decodeResponse : Decoder Response
decodeResponse =
  Pipeline.decode Response
    |> Pipeline.optional "reason" (string) "NULL"

