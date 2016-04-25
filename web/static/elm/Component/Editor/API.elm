module Component.Editor.API (..) where


import Component.Editor.Update exposing (update, Action(..), Addresses)


initialText =
  """
# Heading goes here.

Put [markdown](https://daringfireball.net/projects/markdown/) text here.
"""

editorMailbox : Signal.Mailbox Action
editorMailbox =
  Signal.mailbox NoOp
