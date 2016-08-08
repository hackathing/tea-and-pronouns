module Server.State exposing (Msg)

import Http


type alias Model =
    { status : Status
    , token : Maybe String
    }


type Status
    = RequestInProgress
    | Done


type Msg
    = Login { email : String, password : String }
    | LoginSuccess String
    | LoginFail Http.Error


init : Model
init =
    { status = Done
    , token = Nothing
    }
