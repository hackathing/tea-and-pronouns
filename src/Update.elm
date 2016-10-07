module Update exposing (..)

import State exposing (..)
import Auth.Update as Auth
import Auth.State
import Server.Update as Server
import Server.State
import App.Update as App'
import App.State
import User exposing (User)


doUpdate : Msg -> Model -> ( Model, Cmd Msg )
doUpdate msg model =
    case msg of
        ServerMsg (Server.State.RegisterFail state) ->
            handleAuthFail (Server.State.RegisterFail state) model

        ServerMsg (Server.State.LoginFail state) ->
            handleAuthFail (Server.State.RegisterFail state) model

        ServerMsg (Server.State.AuthSuccess user) ->
            initApp user model |> updateServer (Server.State.AuthSuccess user)

        ServerMsg msg ->
            updateServer msg model

        AuthMsg (Auth.State.DoRegister state) ->
            updateServer (Server.State.Register state) model

        AuthMsg (Auth.State.DoLogin state) ->
            updateServer (Server.State.Login state) model

        AuthMsg msg ->
            updateAuth msg model

        AppMsg msg ->
            updateApp msg model


initApp : User -> Model -> Model
initApp user model =
    { model | auth = Auth.State.init, app = Just (App.State.init user) }


handleAuthFail : Server.State.Msg -> Model -> ( Model, Cmd Msg )
handleAuthFail msg model =
    let
        ( authModel, _ ) =
            Auth.update Auth.State.AuthFail model.auth
    in
        updateServer msg { model | auth = authModel }


updateServer : Server.State.Msg -> Model -> ( Model, Cmd Msg )
updateServer msg model =
    let
        ( serverModel, cmd ) =
            Server.update msg model.server
    in
        ( { model | server = serverModel }
        , Cmd.map ServerMsg cmd
        )


updateAuth : Auth.State.Msg -> Model -> ( Model, Cmd Msg )
updateAuth msg model =
    let
        ( authModel, cmd ) =
            Auth.update msg model.auth
    in
        ( { model | auth = authModel }
        , Cmd.map AuthMsg cmd
        )


updateApp : App.State.Msg -> Model -> ( Model, Cmd Msg )
updateApp msg model =
    case model.app of
        Just appModel ->
            let
                ( newAppModel, cmd ) =
                    App'.update msg appModel
            in
                ( { model | app = Just newAppModel }
                , Cmd.map AppMsg cmd
                )

        Nothing ->
            ( model, Cmd.none )


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
