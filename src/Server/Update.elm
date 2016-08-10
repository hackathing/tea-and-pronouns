module Server.Update exposing (update)

import Http
import Task
import User
import Server.Json as Json
import Server.State exposing (..)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Register state ->
            ( model, doRegister state )

        RegisterSuccess user ->
            Debug.crash "TODO"

        RegisterFail error ->
            Debug.crash "TODO"


doRegister : { email : String, password : String } -> Cmd Msg
doRegister state =
    let
        payload =
            Http.string (Json.auth state)

        cmd =
            Http.post User.fromAuthJson "//localhost:3000/users" payload
    in
        Task.perform RegisterFail RegisterSuccess cmd
