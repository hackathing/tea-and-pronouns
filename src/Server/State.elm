module Server.State exposing (Msg(..), Status(..), Model, init)

import Http
import User exposing (User)
import Auth.State exposing (AuthCredentials)


type alias Model =
    { status : Status
    , token : Maybe String
    }


type Status
    = Error String
    | Waiting
    | Ready


type Msg
    = Register AuthCredentials
    | Login AuthCredentials
    | AuthSuccess User
    | LoginFail Http.Error
    | RegisterFail Http.Error


init : Model
init =
    { status = Ready
    , token = Nothing
    }
