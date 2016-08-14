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
            ( model, doRegister state )

        Login state ->
            ( model, doLogin state )

        AuthSuccess user ->
            ( { model | token = Just user.token }, Cmd.none )

        AuthFail error ->
            Debug.crash "TODO"


doRegister : AuthCredentials -> Cmd Msg
doRegister =
    doAuth "//localhost:3000/users"


doLogin : AuthCredentials -> Cmd Msg
doLogin =
    doAuth "TODO"


doAuth : String -> AuthCredentials -> Cmd Msg
doAuth url state =
    { verb = "POST"
    , url = url
    , headers = headers
    , body = Http.string (Json.auth state)
    }
        |> Http.send Http.defaultSettings
        |> Http.fromJson User.fromAuthJson
        |> Task.perform AuthFail AuthSuccess


headers : List ( String, String )
headers =
    [ ( "Content-Type", "application/json" )
    , ( "Accept", "application/json" )
    ]
