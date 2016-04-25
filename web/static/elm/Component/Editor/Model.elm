module Component.Editor.Model (..) where


type alias Model a =
  { a
  | inputText : String
  }
