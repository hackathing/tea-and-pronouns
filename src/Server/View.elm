module Server.View exposing (root)

import Html exposing (..)
import Server.State exposing (..)


root : Model -> Html a
root model =
    case model.status of
        Ready ->
            div [] []

        Waiting ->
            div [] [ text "Request in progress..." ]

        Error n ->
            div [] [ text n ]
