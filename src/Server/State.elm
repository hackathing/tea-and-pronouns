module Server.State exposing (Msg(..), Status(..), Model, init)

import Http
import User exposing (User)
import Auth.State exposing (AuthCredentials)


type alias Model =
    { status : Status
    , token : Maybe String
    , routes : Routes
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


type alias Routes =
    { login : String
    , register : String
    }


routes : String -> Routes
routes host =
    { login = host ++ "/login"
    , register = host ++ "/register"
    }


init : Model
init =
    { status = Ready
    , token = Nothing
    , routes = routes "//localhost:3000"
    }
