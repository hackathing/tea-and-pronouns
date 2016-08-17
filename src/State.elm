module State exposing (Model, Flags, Msg(..), init)

import App.State as App
import Auth.State as Auth
import Server.State as Server


type alias Model =
    { auth : Auth.Model
    , server : Server.Model
    , app : Maybe App.Model
    }


type alias Flags =
    {}


type Msg
    = AuthMsg Auth.Msg
    | ServerMsg Server.Msg
    | AppMsg App.Msg


init : Flags -> ( Model, Cmd Msg )
init flags =
    ( { auth = Auth.init
      , server = Server.init
      , app = Nothing
      }
    , Cmd.none
    )
