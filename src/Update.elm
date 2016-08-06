module Update exposing (..)

import State exposing (..)
import Auth.Update as Auth


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case debug msg model of
        AuthMsg msg ->
            ( { model
                | auth = Auth.update msg model.auth
              }
            , Cmd.none
            )


debug : Msg -> Model -> Msg
debug msg model =
    let
        _ =
            Debug.log "Msg" msg

        _ =
            Debug.log "Model" model
    in
        msg
