module Main exposing (main)

import Html.App as App
import Html exposing (..)
import State exposing (..)
import Update exposing (..)
import Auth.View
import Server.View


main : Program Flags
main =
    App.programWithFlags
        { init = init
        , view = view
        , subscriptions = subscriptions
        , update = update
        }


subscriptions : Model -> Sub a
subscriptions model =
    Sub.none


view : Model -> Html Msg
view model =
    div []
        [ Server.View.root model.server
        , App.map AuthMsg <| Auth.View.root model.auth
        ]
