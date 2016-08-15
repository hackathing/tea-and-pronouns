module State exposing (Model, Flags, Msg(..), init)

import Auth.State as Auth
import Server.State as Server


type alias Model =
    { auth : Auth.Model
    , server : Server.Model
    }


type alias Flags =
    {}


type Msg
    = AuthMsg Auth.Msg
    | ServerMsg Server.Msg


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { auth = Auth.init
      , server = Server.init
      }
    , Cmd.none
    )
