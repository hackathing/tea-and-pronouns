module Server.State exposing (Msg(..), Status(..), Model, init)

import Http
import User exposing (User)


type alias Model =
    { status : Status
    , token : Maybe String
    }


type Status
    = RequestInProgress
    | Error String
    | None


type Msg
    = Register { email : String, password : String }
    | Login { email : String, password : String }
    | AuthSuccess User
    | AuthFail Http.Error


init : Model
init =
    { status = None
    , token = Nothing
    }
