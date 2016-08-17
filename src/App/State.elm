module App.State exposing (Model, Msg(..), init)

import User exposing (User)


type Msg
    = Noop


type alias Model =
    { user : User
    }


init : User -> Model
init =
    Model
