module Types exposing(..)

type Game
  = GameOver (Board, GameState)
  | StartingGame
  | GameInProgress (Board, GameState)

type alias Board = List Column

type alias GameState =
  { score : Int }

type alias Column = List Stone

type Stone = Color Int

type Event
  = Wait
  | Restart
  | NewGame Board
