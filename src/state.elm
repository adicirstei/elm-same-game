{-module State exposing (init, update)-}

module State exposing(..)


import Types exposing (Game, Event(..), Board, Column)
import Random exposing (generate)
import Random.Board exposing (..)
import List.Extra as List



init : ( Types.Game, Cmd Types.Event )
init = Types.StartingGame ! [Random.generate NewGame board]

augmentBoard : Board -> Types.AugmentedBoard
augmentBoard b =
  b |> List.indexedMap (\colIdx col -> List.indexedMap (\rowIdx (Types.Color v) -> ((colIdx, rowIdx), v)) col)


--
-- getGroup : Board -> (Int,Int) -> Array (Int, Int)
-- getGroup b (c, r) = Array.fromList [(c, r)]
--

collectCol : Types.AugmentedStone -> Types.AugmentedColumn -> List Types.Position
collectCol ((c, r), val) col =
  (List.takeLeft (\ (_, v) -> v == val) (List.take r col)
   |> List.map (\ (p, _) -> p))
   ++  [(c,r)]




makeMove : Game -> Int -> Int -> Game
makeMove m c r =
  case m of
    Types.GameInProgress (b, s) ->
      m
    _ -> m



update : Types.Event -> Types.Game -> ( Types.Game, Cmd Types.Event )
update ev m =
  case ev of
    NewGame board -> (Types.GameInProgress (board, { score = 0 }), Cmd.none)
    Restart -> init
    Wait -> (m, Cmd.none)
    StoneClicked c r ->
      let
        move = makeMove m
      in
        (move c r, Cmd.none)
