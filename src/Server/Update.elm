module Server.Update exposing (update)

import Http
import Task
import User
import Server.Json as Json
import Server.State exposing (..)
import Auth.State exposing (AuthCredentials)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Register state ->
            ( { model | status = Waiting }
            , doRegister state
            )

        Login state ->
            ( { model | status = Waiting }
            , doLogin state
            )

        AuthSuccess user ->
            ( { model | token = Just user.token, status = Ready }
            , Cmd.none
            )

        LoginFail error ->
            ( { model | status = Error "Unable to login" }
            , Cmd.none
            )

        RegisterFail error ->
            ( { model | status = Error "Unable to register" }
            , Cmd.none
            )


doRegister : AuthCredentials -> Cmd Msg
doRegister =
    doAuth "//localhost:3000/register" RegisterFail


doLogin : AuthCredentials -> Cmd Msg
doLogin =
    doAuth "TODO" LoginFail


doAuth : String -> (Http.Error -> Msg) -> AuthCredentials -> Cmd Msg
doAuth url msg state =
    { verb = "POST"
    , url = url
    , headers = headers
    , body = Http.string (Json.auth state)
    }
        |> Http.send Http.defaultSettings
        |> Http.fromJson User.fromAuthJson
        |> Task.perform msg AuthSuccess


headers : List ( String, String )
headers =
    [ ( "Content-Type", "application/json" )
    , ( "Accept", "application/json" )
    ]
