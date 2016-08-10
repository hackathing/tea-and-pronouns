module Update exposing (..)

import State exposing (..)
import Auth.Update as Auth
import Server.Update as Server


doUpdate : Msg -> Model -> ( Model, Cmd Msg )
doUpdate msg model =
    case msg of
        AuthMsg msg ->
            let
                ( authModel, cmd ) =
                    Auth.update msg model.auth
            in
                ( { model | auth = authModel }
                , Cmd.map AuthMsg cmd
                )

        ServerMsg msg ->
            let
                ( serverModel, cmd ) =
                    Server.update msg model.server
            in
                ( { model | server = serverModel }
                , Cmd.map ServerMsg cmd
                )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    let
        ( newModel, cmd ) =
            doUpdate msg model

        _ =
            Debug.log "Model" newModel

        _ =
            Debug.log "Cmd" cmd

        _ =
            Debug.log "Msg" msg
    in
        ( newModel, cmd )
