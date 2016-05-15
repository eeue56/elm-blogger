module Component.Editor.Model exposing(..) -- where

import Phoenix.Channel.Model

type alias Model a =
  Phoenix.Channel.Model.Model
    { a
    | inputText : String
    , channelName : String
    }
