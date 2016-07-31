module View exposing (view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onClick)
import Types exposing (Game(..), Board, Column, Stone(..), Event(..), GameState)
import Maybe

type alias CssColor = String



gameOver : Board -> GameState -> Html Event
gameOver board state =
  div [] [ text <| toString state ]

colors : List CssColor
colors = ["#FF0000", "rgb(52, 156, 36)", "rgb(45, 45, 153)", "#fcfc00", "rgb(9, 201, 201)", "#FF00FF"]


color : Int -> CssColor
color idx =
  colors
  |> List.drop idx
  |> List.head
  |> Maybe.withDefault "#000000"

statusBar : GameState -> Html Event
statusBar state =
  div [ style [("clear", "left"), ("background", "grey")] ] [ text "Score :", text <| toString state.score]

controls : Html Event
controls =
  div [ style [("clear", "left"), ("float", "left")]] [ button [onClick Restart] [text "NewGame"] ]

board : Board -> Html Event
board b =
  div
    [ style [("width", "420px"), ("height", "420px"), ("float", "left")] ] (List.indexedMap column b)

column : Int -> Column -> Html Event
column i c =
  let cStone = stone i
  in
    div
      [ style [("height", "420px"), ("float", "left")] ] (List.indexedMap cStone c)

stone : Int -> Int -> Stone -> Html Event
stone c r (Color idx) =
  div
    [ style [("width", "24px"), ("height", "24px"), ("background", color idx), ("border", "solid 1px white")]
    , onClick (StoneClicked c r)]
    []


view : Game -> Html Event
view game =
  case game of
    StartingGame -> text "Wait for game to start"
    GameOver (b, state) ->
      gameOver b state
    GameInProgress (b, state) ->
      div [] [board b, controls, statusBar state]
