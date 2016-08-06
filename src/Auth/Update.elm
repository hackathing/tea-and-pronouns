module Auth.Update exposing (update)

import Auth.State exposing (..)


update : Msg -> Model -> Model
update msg model =
    case msg of
        ChangePage page ->
            { model | page = page }
