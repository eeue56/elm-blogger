module Component.Editor.Model exposing(..) -- where

type alias Model a =
  { a
  | inputText : String
  , channelName : String
  , refNumber : Int
  , connected : Bool
  }
