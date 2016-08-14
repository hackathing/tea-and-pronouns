module Server.State exposing (Msg(..), Status(..), Model, init)

import Http
import User exposing (User)
import Auth.State exposing (AuthCredentials)


type alias Model =
    { status : Status
    , token : Maybe String
    }


type Status
    = RequestInProgress
    | Error String
    | None


type Msg
    = Register AuthCredentials
    | Login AuthCredentials
    | AuthSuccess User
    | AuthFail Http.Error


init : Model
init =
    { status = None
    , token = Nothing
    }
