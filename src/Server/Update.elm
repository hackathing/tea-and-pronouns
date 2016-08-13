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

        Login state ->
            ( model, doLogin state )

        AuthSuccess user ->
            ( { model | token = Just user.token }, Cmd.none )

        AuthFail error ->
            Debug.crash "TODO"


doRegister : { email : String, password : String } -> Cmd Msg
doRegister =
    doAuth "//localhost:3000/users"


doLogin : { email : String, password : String } -> Cmd Msg
doLogin =
    doAuth "TODO"


doAuth : String -> { email : String, password : String } -> Cmd Msg
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
