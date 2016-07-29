module State exposing (init, update)

import Types exposing (Game, Event(..))
import Random exposing (generate)
import Random.Board exposing (..)

init : ( Types.Game, Cmd Types.Event )
init = Types.StartingGame ! [Random.generate NewGame board]

update : Types.Event -> Types.Game -> ( Types.Game, Cmd Types.Event )
update ev m =
  case ev of
    NewGame board -> (Types.GameInProgress (board, { score = 0 }), Cmd.none)
    Restart -> init
    Wait -> (m, Cmd.none)
