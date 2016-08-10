module Server.State exposing (Msg(..), Model, init)

import Http
import User exposing (User)


type alias Model =
    { status : Status
    , token : Maybe String
    }


type Status
    = RequestInProgress
    | Done


type Msg
    = Register { email : String, password : String }
    | RegisterSuccess User
    | RegisterFail Http.Error


init : Model
init =
    { status = Done
    , token = Nothing
    }
