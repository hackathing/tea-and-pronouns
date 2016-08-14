module Server.View exposing (root)

import Html exposing (..)
import Server.State exposing (..)


root : Model -> Html a
root model =
    case model.status of
        None ->
            div [] []

        RequestInProgress ->
            div [] [ text "Request in progress..." ]

        Error n ->
            div [] [ n |> toString |> text ]
