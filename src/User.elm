module User exposing (User, fromAuthJson)

import Json.Decode exposing (..)


type alias User =
    { email : String
    , token : String
    }


fromAuthJson : Decoder User
fromAuthJson =
    at [ "user" ] <|
        object2 User
            ("email" := string)
            ("token" := string)
