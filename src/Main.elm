module Main exposing (..)

import Html exposing (..)
import Html.App as App
import Types exposing (..)


main : Program Flags
main =
    App.programWithFlags
        { init = init
        , view = view
        , subscriptions = subscriptions
        , update = update
        }


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( {}, Cmd.none )


subscriptions : Model -> Sub a
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ text "Hi there"
        ]
