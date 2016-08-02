{-module State exposing (init, update)-}

module State exposing(..)


import Types exposing (Game, Event(..), Board, Column)
import Random exposing (generate)
import Random.Board exposing (..)
import List.Extra as List

b = [ [Types.Color 0, Types.Color 1, Types.Color 1, Types.Color 2, Types.Color 1]
    , [Types.Color 0, Types.Color 1, Types.Color 1, Types.Color 2, Types.Color 1]]

ab = augmentBoard b
ac = [((0,0),0),((0,1),1),((0,2),1),((0,3),2),((0,4),1)]


init : ( Types.Game, Cmd Types.Event )
init = Types.StartingGame ! [Random.generate NewGame board]

augmentBoard : Board -> Types.AugmentedBoard
augmentBoard b =
  b |> List.indexedMap (\colIdx col -> List.indexedMap (\rowIdx (Types.Color v) -> ((colIdx, rowIdx), v)) col)

collectCol : Types.AugmentedStone -> Types.AugmentedColumn -> List Types.Position
collectCol ((c, r), val) col =
  let
    left = List.take r col
    right = List.drop (r + 1) col
  in
  (List.takeLeft (\ (_, v) -> v == val) left
   |> List.map fst)
   ++  [(c,r)]
   ++ (List.takeRight (\ (_, v) -> v == val) right
        |> List.map fst)




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
