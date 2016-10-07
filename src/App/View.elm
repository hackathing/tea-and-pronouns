module App.View exposing (root)

import Html exposing (..)
import Html.Attributes exposing (..)
import App.State exposing (..)


root : Model -> Html Msg
root model =
    div [] [ text "Welcome!" ]
