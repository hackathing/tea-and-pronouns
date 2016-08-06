module State exposing (Model, Flags, Msg(AuthMsg), init)

import Auth.State as Auth


type alias Model =
    { auth : Auth.Model
    }


type alias Flags =
    {}


type Msg
    = AuthMsg Auth.Msg


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { auth = Auth.init
      }
    , Cmd.none
    )
