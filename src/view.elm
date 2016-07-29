module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Types exposing (Game(..), Board, Column, Stone(..), Event(..))
import Maybe


gameOver board state =
  text <| toString state

colors = ["#FF0000", "#00FF00", "#0000FF", "#FFFF00", "#00FFFF", "#FF00FF"]

color idx =
  colors
  |> List.drop idx
  |> List.head
  |> Maybe.withDefault "#000000"


statusBar state =
  div [ style [("clear", "left"), ("background", "grey")] ] [ text "Score :", text <| toString state.score]

controls =
  div [] [ button [onClick Restart] [text "NewGame"] ]

board : Board -> Html Event
board b =
  div
    [ style [("width", "420px"), ("height", "420px"), ("float", "left")] ] (List.map column b)

column : Column -> Html Event
column c =
  div
    [ style [("height", "420px"), ("float", "left")] ] (List.map stone c)

stone : Stone -> Html Event
stone (Color idx) =
  div
    [ style [("width", "24px"), ("height", "24px"), ("background", color idx), ("border", "solid 1px white")] ]
    []

view : Game -> Html Event
view game =
  case game of
    StartingGame -> text "Wait for game to start"
    GameOver (b, state) ->
      gameOver b state
    GameInProgress (b, state) ->
      div [] [board b, controls, statusBar state]
