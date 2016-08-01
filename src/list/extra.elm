module List.Extra exposing (..)

import Maybe

get : Int -> List a -> Maybe a
get idx lst =
  lst
  |> List.drop idx
  |> List.head


takeLeft : (a -> Bool) -> List a -> List a
takeLeft pred xs =
  case xs of
    [] -> []
    x :: tail ->
      if pred x
        then x :: takeLeft pred tail
        else []


takeRight : (a -> Bool) -> List a -> List a
takeRight pred xs =
    List.reverse
    <| case List.reverse xs of
         [] -> []
         x :: tail ->
           if pred x
             then x :: takeLeft pred tail
             else []
