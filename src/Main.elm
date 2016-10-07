module Main exposing (main)

import Html.App as App
import Html exposing (..)
import State exposing (..)
import Update exposing (..)
import Auth.View
import Server.View
import App.View


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
    let
        view =
            case model.app of
                Nothing ->
                    App.map AuthMsg <| Auth.View.root model.auth

                Just appModel ->
                    App.map AppMsg <| App.View.root appModel
    in
        div []
            [ Server.View.root model.server
            , view
            ]
