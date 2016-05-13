module MyWebSocket exposing (..) --where

import WebSocket

send : String -> Cmd msg
send string =
  WebSocket.send "ws://localhost:4000/socket/websocket" string
