module App.Update exposing (update)

import App.State exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( model, Cmd.none )
