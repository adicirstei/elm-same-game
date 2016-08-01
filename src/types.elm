module Types exposing(..)

type Game
  = GameOver (Board, GameState)
  | StartingGame
  | GameInProgress (Board, GameState)

type alias Position = (Int, Int)

type alias AugmentedStone = (Position, Int)
type alias AugmentedColumn = List AugmentedStone
type alias AugmentedBoard = List AugmentedColumn

type alias Board = List Column

type alias GameState =
  { score : Int }

type alias Column = List Stone

type Stone = Color Int

type Event
  = Wait
  | Restart
  | NewGame Board
  | StoneClicked Int Int
