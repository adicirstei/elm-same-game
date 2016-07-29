module Same exposing (main)

import Html.App as App
import Html.Events exposing (onClick)

import Types
import State
import View

subscriptions : Types.Game -> Sub Types.Event
subscriptions m
  = Sub.none


main = App.program
  { init = State.init
  , subscriptions = subscriptions
  , update = State.update
  , view = View.view
  }
