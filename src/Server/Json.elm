module Server.Json exposing (..)

import Json.Encode exposing (..)
import Auth.State exposing (AuthCredentials)


auth : AuthCredentials -> String
auth values =
    [ ( "user"
      , object
            [ ( "email", string values.email )
            , ( "password", string values.password )
            ]
      )
    ]
        |> object
        |> encode 0
