module User exposing (User, fromAuthJson)

import Json.Decode exposing (..)


type alias User =
    { email : String
    , token : String
    , drink : Drink
    , pronouns : Maybe String
    }


type alias Drink =
    { type' : Maybe String
    }


newDrink : Drink
newDrink =
    Drink Nothing


fromAuthJson : Decoder User
fromAuthJson =
    at [ "user" ] <|
        object4 User
            ("email" := string)
            ("token" := string)
            -- TODO: Parse values from server
            (succeed newDrink)
            (succeed Nothing)
