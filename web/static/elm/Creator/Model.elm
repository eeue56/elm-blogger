module Creator.Model exposing (..) -- where

import Component.Editor.Model as EditorModel
import Phoenix.Channel.Model as ChannelModel


type alias Model =
  ChannelModel.Model (EditorModel.Model {})
