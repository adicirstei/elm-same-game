module Random.Board exposing (board)

import Types exposing (Column, Board, Stone(..))

import Random exposing(..)

size : Int
size = 15

colors : List Int
colors = []

stone : Generator Stone
stone = Random.map Color (Random.int 0 4)

column : Generator Column
column = Random.list size stone

board : Random.Generator Board
board = Random.list size column
