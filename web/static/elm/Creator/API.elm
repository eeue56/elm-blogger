module Creator.API where

import Creator.Update exposing (..)

creatorMailbox : Signal.Mailbox Action
creatorMailbox = Signal.mailbox NoOp
