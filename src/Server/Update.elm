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
    { verb = "POST"
    , headers =
        [ ( "Content-Type", "application/json" )
        , ( "Accept", "application/json" )
        ]
    , url = "//localhost:3000/users"
    , body = Http.string (Json.auth state)
    }
        |> Http.send Http.defaultSettings
        |> Http.fromJson User.fromAuthJson
        |> Task.perform RegisterFail RegisterSuccess
